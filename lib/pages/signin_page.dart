import 'package:auth/widget/Buttons/google_button.dart';
import 'package:auth/widget/Buttons/purple_button.dart' as purple;
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../services/auth_service.dart';
import '../themes/colors.dart';
import '../widget/Backgrounds/bg.dart';
import '../widget/Buttons/link_button.dart';
import '../widget/Inputs/password_field.dart';
import '../widget/header.dart';

class SigninPage extends StatefulWidget {
  SigninPage({super.key, String? selectedItem});

  @override
  State<SigninPage> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninPage> {
  //text controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? emailError;
  String? passwordError;

  void validateSignin() async {
    String? authError = await AuthService()
        .signin(email: emailController.text, password: passwordController.text);

    if (authError != null) {
      setState(
        () {
          if (authError == 'E-mail inválido') {
            emailError = 'E-mail inválido';
          } else if (authError == 'Senha inválida') {
            passwordError = 'Senha inválida';
          }
        },
      );
    }
    if (authError == null) {
      Navigator.pushNamed(context, '/');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderWithLogo(),
      body: Bg(
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'Entrar',
                style: Theme.of(context).primaryTextTheme.titleLarge?.copyWith(
                      color: MyColors.primary500,
                    ),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: 400,
                child: TextField(
                  controller: emailController,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                  decoration: InputDecoration(
                    errorText: emailError,
                    labelText: 'E-mail',
                    prefixIcon: const Icon(PhosphorIcons.envelope),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              PasswordField(
                errorText: passwordError,
                controller: passwordController,
                label: 'Senha',
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 400,
                child: Row(
                  children: [
                    LinkButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/forgotpassword');
                      },
                      text: 'Esqueceu a Senha?',
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                width: 400,
                child: purple.PurpleButton(
                    onPressed: validateSignin,
                    text: "Entrar",
                    type: purple.ButtonType.fill),
              ),
              const SizedBox(
                height: 15,
              ),
              const SizedBox(width: 400, child: Divider()),
              const SizedBox(
                height: 15,
              ),
              SizedBox(width: 400, child: GoogleSignInButton()),
              const SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Não possui conta? ',
                    style: TextStyle(color: Colors.black),
                  ),
                  LinkButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signup');
                    },
                    text: 'Criar Conta',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
