import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId:
        '422819166801-q3ehdqgj3sbn4bf0aker12kn0ohjno1p.apps.googleusercontent.com',
  );

  Future<String?> signup({
    required String email,
    required String password,
    required String name,
    required String surname,
    required DateTime date,
  }) async {
    try {
      UserCredential? userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      //create a user document and add to firestore
      creteUserDocument(userCredential, name, surname, date);
      return null; // Retorna null se o cadastro for bem-sucedido.
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'Já existe uma conta com esse e-mail.';
      } else if (e.code == 'invalid-email') {
        return 'O e-mail fornecido é inválido.';
      }
    }
    return null;
  }

  Future<void> creteUserDocument(
    UserCredential? userCredential,
    String name,
    String surname,
    DateTime date,
  ) async {
    if (userCredential != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'name': name,
        'surname': surname,
        'createdAt': date,
      });
      //criar um documento de usuário no firestore
    }
  }

  Future<String?> signin(
      {required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return 'E-mail inválido';
      } else if (e.code == 'invalid-credential') {
        return 'Senha inválida';
      }
      return null;
    }

    return null;
  }

// Sign in with Google
  Future<User?> signinWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        return null; // User canceled the sign-in
      }

      // Obtain the Google authentication
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential for Firebase Authentication
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      // Check if user already exists in Firestore
      await _checkUserInFirestore(userCredential);

      return userCredential.user;
    } catch (e) {
      print("Error signing in with Google: $e");
      return null;
    }
  }

  // Check if user exists in Firestore
  Future<void> _checkUserInFirestore(UserCredential userCredential) async {
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(userCredential.user!.email)
        .get();

    if (!userDoc.exists) {
      // Create the user document if not found
      await creteUserDocument(
          userCredential, 'Ana', 'Lenckulh', DateTime.now());
    }
  }

// Log out the user
  Future<void> signout() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      if (user.providerData
          .any((provider) => provider.providerId == 'google.com')) {
        // If the user is logged in via Google, sign them out from Google as well
        await _googleSignIn.signOut();
        print("User signed out from Google");
      }
      // Sign out from Firebase Auth
      await signout();
      print("User signed out");
    } else {
      print("No user is currently signed in");
    }
  }
}
