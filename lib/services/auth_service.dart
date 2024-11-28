import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  Future<String?> signup({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential? userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return null; // Retorna null se o cadastro for bem-sucedido.
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        return 'Já existe uma conta com esse e-mail.';
      } else if (e.code == 'invalid-email') {
        return 'O e-mail fornecido é inválido.';
      }
    }
    return null; // Se não houver erro específico, retorna null.
  }
}

Future<String?> signin(
    {required String email, required String password}) async {
  try {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'invalid-email') {
      return 'Nenhum usuário possui esse e-mail';
    } else if (e.code == 'invalid-credential') {
      return 'Senha inválida';
    }
  }
  return null;
}

Future<void> signout() async {
  await FirebaseAuth.instance.signOut();
}
