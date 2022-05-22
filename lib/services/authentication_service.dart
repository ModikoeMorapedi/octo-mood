import 'package:firebase_auth/firebase_auth.dart';
import 'package:octo_mood/models/person.dart';
import 'package:octo_mood/utils/strings_util.dart';

class AuthenticationService {
  //Registration method used to register new users in the Database
  Future<String?> registration(
      {required String? email, required String? password}) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email!,
        password: password!,
      );
      print(userCredential.user);
      return StringsUtil.success;
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

  //Login method  used for login in to the App to be able set your moood
  Future<String?> login({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return StringsUtil.success;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      } else {
        return e.message;
      }
    } catch (e) {
      return e.toString();
    }
  }
}
