// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PasswordFieldController {
  bool obscureText = true;

  void updateObscureText() {
    obscureText = !obscureText;
  }
}

class PasswordField extends StatefulWidget {
  final String label; // Novo parâmetro para o rótulo

  const PasswordField({
    super.key,
    this.label = 'Senha',
    required TextEditingController controller, // Rótulo padrão
  });

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  final PasswordFieldController controller = PasswordFieldController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: TextField(
        obscureText: controller.obscureText,
        decoration: InputDecoration(
          labelText: widget.label, // Usar o parâmetro label aqui
          suffixIcon: IconButton(
            icon: Icon(
              controller.obscureText
                  ? PhosphorIcons.eyeClosed // Ícone de olho fechado
                  : PhosphorIcons.eye, // Ícone de olho aberto
            ),
            onPressed: () {
              setState(() {
                controller.updateObscureText(); // Atualiza o estado
              });
            },
          ),
          prefixIcon: Icon(PhosphorIcons.lock),
        ),
      ),
    );
  }
}

class PasswordConfirmationField extends StatefulWidget {
  final String label; // Novo parâmetro para o rótulo

  const PasswordConfirmationField({
    super.key,
    this.label = 'Senha', // Rótulo padrão
  });

  @override
  _PasswordConfirmationFieldState createState() =>
      _PasswordConfirmationFieldState();
}

class _PasswordConfirmationFieldState extends State<PasswordConfirmationField> {
  final PasswordFieldController controller = PasswordFieldController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: TextField(
        obscureText: controller.obscureText,
        decoration: InputDecoration(
          labelText: widget.label, // Usar o parâmetro label aqui
          suffixIcon: IconButton(
            icon: Icon(
              controller.obscureText
                  ? PhosphorIcons.eyeClosed // Ícone de olho fechado
                  : PhosphorIcons.eye, // Ícone de olho aberto
            ),
            onPressed: () {
              setState(() {
                controller.updateObscureText(); // Atualiza o estado
              });
            },
          ),
          prefixIcon: Icon(PhosphorIcons.lock),
        ),
      ),
    );
  }
}
