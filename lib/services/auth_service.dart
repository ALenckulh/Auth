import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthService {
  Future<void> signup({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential? userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('An account already exists with that email.');
      } else if (e.code == 'invalid-email') {
        print('The email provided is invalid.');
      } else if (e.code == 'operation-not-allowed') {
        print('Email/password accounts are not enabled.');
      }
    } catch (e) {
      print('Unexpected error: $e');
    }
  }
}

Future<void> signin(
    {required String email,
    required String password,
    required BuildContext context}) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    String message = '';
    if (e.code == 'invalid-email') {
      message = 'No user found for that email.';
    } else if (e.code == 'invalid-credential') {
      message = 'Wrong password provided for that user.';
    }
  } catch (e) {}
}

Future<void> signout() async {
  await FirebaseAuth.instance.signOut();
}
