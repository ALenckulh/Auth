import 'package:auth/widget/Buttons/link_button.dart';
import 'package:auth/widget/Buttons/purple_button.dart' as purple;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import '../themes/colors.dart';
import '../widget/Backgrounds/bg.dart';
import '../widget/Cards/custom_big_card.dart';
import '../widget/Inputs/custom_date_picker.dart';
import '../widget/Inputs/password_field.dart';
import '../widget/header.dart';

final TextEditingController nameController = TextEditingController();
final TextEditingController surnameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmPasswordController = TextEditingController();
bool dateError = false;

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key, String? selectedItem});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  DateTime? selectedDate;
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderWithLogo(),
      body: Bg(
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            CustomBigCard(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Criar Conta',
                      style: Theme.of(context)
                          .primaryTextTheme
                          .titleLarge
                          ?.copyWith(
                            color: MyColors.primary500,
                          ),
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    SizedBox(
                      width: 400,
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: 'Nome',
                          prefixIcon: Icon(PhosphorIcons.user),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 400,
                      child: TextField(
                        controller: surnameController,
                        decoration: const InputDecoration(
                          labelText: 'Sobrenome',
                          prefixIcon: Icon(PhosphorIcons.user),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 400,
                      child: TextField(
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: 'E-mail',
                          prefixIcon: Icon(PhosphorIcons.envelope),
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
                        errorText: "Release date is required",
                        buttonText: "Select a release date",
                        onDateSelected: (date) {
                          setState(() {
                            selectedDate = date;
                            dateError = date == null;
                          });
                        },
                        hasError: dateError,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    PasswordField(
                      controller: passwordController,
                      label: 'Senha',
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const PasswordConfirmationField(
                      label: 'Confirmar senha',
                    ),
                    const SizedBox(
                      height: 28,
                    ),
                    SizedBox(
                      width: 400,
                      child: purple.PurpleButton(
                        onPressed: () {
                          final userData = {
                            "name": nameController.text,
                            "surname": surnameController.text,
                            "email": emailController.text,
                            "password": passwordController.text,
                            "birthday": selectedDate?.toIso8601String(),
                          };
                          if (kDebugMode) {
                            print(userData);
                          }
                        },
                        text: "Criar",
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
          ],
        ),
      ),
    );
  }
}
