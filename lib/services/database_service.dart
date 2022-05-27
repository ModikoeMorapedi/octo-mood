import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:basic_utils/basic_utils.dart';

class DatabaseService {
  CollectionReference users = FirebaseFirestore.instance
      .collection('moods'); // Get collection from firestore Database
  static final _firebaseAuth = FirebaseAuth.instance;
  static User? get currentUser =>
      _firebaseAuth.currentUser; // Get the current user that is logged in

  ///fcm fcm

  // This method is used to add new users to Firestore Database
  void createNewUserInFirestore(String? nickName) {
    // final CollectionReference<Map<String, dynamic>> newUser =
    //     FirebaseFirestore.instance.collection('moods');

    FirebaseMessaging.instance.getToken().then((token) {
      users.doc(currentUser!.uid).set({
        'id': currentUser!.uid,
        'email': currentUser!.email,
        'nickName': nickName,
        'mood': "😎 🙃 🥳", //Default mood for all added users
        'createdAt': FieldValue.serverTimestamp(),
        'deviceToken': token
      });
    });

    currentUser!.updateDisplayName(
      nickName,
    );
  }

  // This method is used to update or to add mood of singed in Users
  Future<void> addMood(String id, String mood) {
    return users.doc(currentUser!.uid).update({'mood': mood});
  }

  Stream<QuerySnapshot> getData([bool? isDescending]) {
    // Get docs from collection reference and sort them in descending order and ascending
    final querySnapshot = users
        .orderBy('createdAt',
            descending:
                isDescending == null || isDescending == false ? false : true)
        .snapshots();
    return querySnapshot;
  }

  //This is the signout method
  void signOut() async {
    await _firebaseAuth.signOut();
  }

  // Delete profile of signed in user and remove them from Firestore Database
  void deleteProfile(String uid) async {
    //Check if the user IDs match
    if (currentUser!.uid == uid) {
      await users.doc(currentUser!.uid).delete();
      await currentUser!.delete();
      await _firebaseAuth.signOut();
    }
  }

  //
  void sendPushMessage({
    String? body,
    String? title,
    String? user,
    String? token,
  }) async {
    try {
      final postMessage = await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization':
              'key=AAAAxm3P9lM:APA91bER8_tTAMo_VtZNw59SUR0M6cZWs1y8LMK-qOooH1b3fFsXWX3AvSr9Sx9_ytuKCmVvkuJjmXDTcpD1xbYWu0qtK5_p4LeTLOknFuCfcrLxRwfgMUH-2T7k9JzGZw3qnVaav4Tb',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body':
                  "${StringUtils.capitalize(currentUser!.displayName!, allWords: true)} changed your status from $body to $title",
              'title': "Hello ${StringUtils.capitalize(user!, allWords: true)}",
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": token,
          },
        ),
      );

      print(postMessage.body);
    } catch (e) {
      print("error push notification");
    }
  }
}
