import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginService extends ChangeNotifier {
  String _userId = '';

  String getUserId() {
    return _userId;
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential credentials =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _userId = credentials.user!.uid;
      return true;
    } on FirebaseAuthException catch (ex) {
      return false;
    }
  }
}
