import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginService extends ChangeNotifier {
  String _userId = '';
  String _errorMessage = '';

  String getUserId() {
    return _userId;
  }

  void setLoginErrorMessage(String msg) {
    _errorMessage = msg;
    notifyListeners();
  }

  String getErrorMessage() {
    return _errorMessage;
  }

  Future<bool> signInWithEmailAndPassword(String email, String password) async {
    setLoginErrorMessage('');
    try {
      UserCredential credentials =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _userId = credentials.user!.uid;
      return true;
    } on FirebaseAuthException catch (ex) {
      setLoginErrorMessage('Error during sign-in: ' + ex.message!);
      return false;
    }
  }

  Future<bool> createUserWithEmailAndPassword(String email, String pwd) async {
    try {
      UserCredential userCredentials = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: pwd);

      return true; // or userCredentials != null;
    } on FirebaseAuthException {
      return false;
    }
  }

  Future<bool> signOut() {
    Completer<bool> signOutCompleter = Completer();

    FirebaseAuth.instance.signOut().then(
      (value) {
        signOutCompleter.complete(true);
      },
      onError: (error) {
        signOutCompleter.completeError({'error': error});
      },
    );

    return signOutCompleter.future;
  }
}
