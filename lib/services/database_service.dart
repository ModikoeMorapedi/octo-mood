import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  CollectionReference users = FirebaseFirestore.instance
      .collection('moods'); // Get collection from firestore Database
  static final _firebaseAuth = FirebaseAuth.instance;
  static User? get currentUser =>
      _firebaseAuth.currentUser; // Get the current user that is logged in

  // This method is used to add new users to Firestore Database
  void createNewUserInFirestore(String? nickName) {
    final CollectionReference<Map<String, dynamic>> newUser =
        FirebaseFirestore.instance.collection('moods');
    newUser.doc(currentUser!.uid).set({
      'id': currentUser!.uid,
      'email': currentUser!.email,
      'nickName': nickName,
      'mood': "😎 🙃 🥳", //Default mood for all added users
      'createdAt': FieldValue.serverTimestamp(),
    });
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
}
