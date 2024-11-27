import 'package:auth/widget/Buttons/link_button.dart';
import 'package:auth/widget/Buttons/purple_button.dart' as purple;
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../services/auth_service.dart';
import '../themes/colors.dart';
import '../utils/validators.dart';
import '../widget/Backgrounds/bg.dart';
import '../widget/Inputs/custom_date_picker.dart';
import '../widget/Inputs/password_field.dart';
import '../widget/header.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});
  //text controllers

  @override
  State<SignupPage> createState() => _SignupState();
}

class _SignupState extends State<SignupPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();
  String? nameError;
  String? surnameError;
  String? emailError;
  String? passwordError;
  String? confirmPwError;
  String? dateError;
  DateTime? selectedDate;

  void _signup() async {
    setState(() {
      // Aplicar validações nos campos
      nameError = Validators.validateName(nameController.text);
      surnameError = Validators.validateSurname(surnameController.text);
      emailError = Validators.validateEmail(emailController.text);
      passwordError = Validators.validatePassword(passwordController.text);
      confirmPwError = Validators.validateConfirmPassword(
        passwordController.text,
        confirmPwController.text,
      );
      dateError = Validators.validateAge(selectedDate);
    });

    // Verificar se há algum erro
    if ([
      nameError,
      surnameError,
      emailError,
      passwordError,
      confirmPwError,
      dateError
    ].any((error) => error != null)) {
      return; // Não prosseguir se houver erros
    }

    // Se não há erros, realizar o cadastro
    await AuthService().signup(
      email: emailController.text,
      password: passwordController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderWithLogo(),
      body: Bg(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Criar Conta',
                style: Theme.of(context).primaryTextTheme.titleLarge?.copyWith(
                      color: MyColors.primary500,
                    ),
              ),
              const SizedBox(
                height: 28,
              ),
              SizedBox(
                width: 400,
                child: TextField(
                  style: const TextStyle(fontWeight: FontWeight.w600),
                  controller: nameController,
                  decoration: InputDecoration(
                    errorText: nameError,
                    labelText: 'Nome',
                    prefixIcon: const Icon(PhosphorIcons.user),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 400,
                child: TextField(
                  style: const TextStyle(fontWeight: FontWeight.w600),
                  controller: surnameController,
                  decoration: InputDecoration(
                    errorText: surnameError,
                    labelText: 'Sobrenome',
                    prefixIcon: const Icon(PhosphorIcons.user),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 400,
                child: TextField(
                  style: const TextStyle(fontWeight: FontWeight.w600),
                  controller: emailController,
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
              SizedBox(
                width: 400,
                child: CustomDatePicker(
                  // Seletor de data para data de lançamento
                  initialDate: selectedDate,
                  errorText: dateError ?? '',
                  buttonText: "Data de nascimento",
                  onDateSelected: (date) {
                    setState(() {
                      selectedDate = date;
                    });
                  },
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
              PasswordField(
                  errorText: confirmPwError,
                  controller: confirmPwController,
                  label: 'Confirmar senha'),
              const SizedBox(
                height: 28,
              ),
              SizedBox(
                width: 400,
                child: purple.PurpleButton(
                  onPressed: _signup,
                  text: 'Criar',
                  type: purple.ButtonType.fill,
                ),
              ),
              const SizedBox(
                height: 28,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Já possui conta? ',
                    style: TextStyle(color: Colors.black),
                  ),
                  LinkButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/signin');
                    },
                    text: 'Entrar',
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
