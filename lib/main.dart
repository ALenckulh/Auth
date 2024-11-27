import 'package:auth/themes/custom_themes.dart';
import 'package:auth/widget/Buttons/purple_button.dart' as purple;
import 'package:auth/widget/Cards/custom_big_card.dart';
import 'package:auth/widget/header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
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
        '/': (context) => const MyHomePage(
              title: "Repair Café",
            ),
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
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? selectedItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Header(),
      body: Column(
        children: [
          const SizedBox(
            height: 80,
          ),
          CustomBigCard(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  purple.PurpleButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      text: "sign-up"),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
