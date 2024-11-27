import 'package:auth/services/auth_service.dart';
import 'package:auth/themes/colors.dart';
import 'package:auth/themes/custom_themes.dart';
import 'package:auth/widget/Backgrounds/bg.dart';
import 'package:auth/widget/Buttons/link_button.dart';
import 'package:auth/widget/Buttons/purple_button.dart' as purple;
import 'package:auth/widget/Cards/custom_big_card.dart';
import 'package:auth/widget/Inputs/custom_date_picker.dart';
import 'package:auth/widget/Inputs/password_field.dart';
import 'package:auth/widget/header.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auth',
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(),
      },
      theme: CustomThemes().defaultTheme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

final TextEditingController nameController = TextEditingController();
final TextEditingController surnameController = TextEditingController();
final TextEditingController emailController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
final TextEditingController confirmPasswordController = TextEditingController();
bool dateError = false;

class _MyHomePageState extends State<MyHomePage> {
  DateTime? selectedDate;
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeaderWithLogo(),
      body: Bg(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height - 45,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
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
                          style: const TextStyle(fontWeight: FontWeight.w600),
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
                          style: const TextStyle(fontWeight: FontWeight.w600),
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
                          style: const TextStyle(fontWeight: FontWeight.w600),
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
                          onPressed: () async {
                            await AuthService().signup(
                              name: nameController.text,
                              surname: surnameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              confirmPassword: confirmPasswordController.text,
                              birthDate: selectedDate,
                            );
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
            ],
          ),
        ),
      ),
    );
  }
}
