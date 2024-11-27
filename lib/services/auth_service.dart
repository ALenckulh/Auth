import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  Future<String?> signup({
    required String name,
    required String surname,
    required String email,
    required String password,
    required String confirmPassword,
    required DateTime? birthDate,
  }) async {
    try {
      // Create user in Firebase Authentication
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // If the user is created successfully, store additional info in Firestore
      User? user = userCredential.user;
      if (user != null) {
        // Create a reference to the users collection in Firestore
        CollectionReference users =
            FirebaseFirestore.instance.collection('users');

        // Store additional details like name, surname, birthdate, etc.
        await users.doc(user.uid).set({
          'name': name,
          'surname': surname,
          'email': email,
          'birthDate': birthDate?.toIso8601String(),
          // Store birthDate as a string
        });

        return null; // Success, no error message
      }
      return 'Erro ao criar usuário no Firebase Authentication';
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print('Erro ao criar usuário: $e');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Erro ao criar usuário: $e');
      }
    }
  }
}
