import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;

  void createNewUserInFirestore(String? nickName) {
    final CollectionReference<Map<String, dynamic>> newUser =
        FirebaseFirestore.instance.collection('moods');
    newUser.doc(currentUser!.uid).set({
      'id': currentUser!.uid,
      'email': currentUser!.email,
      'nickName': nickName,
      'mood': ""
    });
  }
}
