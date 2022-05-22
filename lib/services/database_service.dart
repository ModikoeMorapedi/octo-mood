import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  CollectionReference users = FirebaseFirestore.instance.collection('moods');
  static final _firebaseAuth = FirebaseAuth.instance;
  static User? get currentUser => _firebaseAuth.currentUser;

  void createNewUserInFirestore(String? nickName) {
    final CollectionReference<Map<String, dynamic>> newUser =
        FirebaseFirestore.instance.collection('moods');
    newUser.doc(currentUser!.uid).set({
      'id': currentUser!.uid,
      'email': currentUser!.email,
      'nickName': nickName,
      'mood': "😎 🙃 🥳",
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> addMood(String id, String mood) {
    return users.doc(currentUser!.uid).update({'mood': mood});
  }

  Stream<QuerySnapshot> getData([bool? isDescending]) {
    // Get docs from collection reference

    final querySnapshot = users
        .orderBy('createdAt',
            descending:
                isDescending == null || isDescending == false ? false : true)
        .snapshots();

    return querySnapshot;
  }

  void signOut() {
    _firebaseAuth.signOut();
  }
}
