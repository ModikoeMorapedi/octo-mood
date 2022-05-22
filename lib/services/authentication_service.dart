import 'package:firebase_auth/firebase_auth.dart';
import 'package:octo_mood/models/person.dart';

class AuthenticationService {
  final _firebaseAuth = FirebaseAuth.instance;
  User? get currentUser => _firebaseAuth.currentUser;
  String? _nickName = "";
  String? get nickName => _nickName;
  Future<String?> registration(
      {String? email, String? password, String? nickName}) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      _nickName = nickName;
      print(userCredential.user);
      return "success";
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
