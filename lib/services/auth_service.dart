import 'package:firebase_auth/firebase_auth.dart';

class AuthServices {
  login(String email, String password) async {
    try {
      FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException {
      throw Exception();
    }
  }

  signUp(String email, String password, String? name) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password.toString());
      FirebaseAuth.instance.currentUser?.updateDisplayName(name);
    } on FirebaseAuthException {
      throw Exception();
    }
  }
}
