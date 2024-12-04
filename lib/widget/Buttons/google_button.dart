import 'package:auth/themes/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart'; // If you're using this package

import '../../services/auth_service.dart';

class GoogleSignInButton extends StatelessWidget {
  GoogleSignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: MyColors.primary300,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () async {
        // Attempt to sign in with Google
        User? user = await AuthService().signinWithGoogle();

        if (user != null) {
          print("User signed in: ${user.displayName}"); // Debugging line
          // Successfully logged in with Google
          Navigator.pushNamed(context, '/');
        } else {
          print("Google sign-in failed"); // Debugging line
        }
      },
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(PhosphorIcons.googleLogo), // Google Icon
          SizedBox(width: 10),
          Text("Sign in with Google"),
        ],
      ),
    );
  }
}
