// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class PasswordField extends StatefulWidget {
  final String label;
  final String? errorText;
  final TextEditingController controller;

  const PasswordField({
    super.key,
    this.errorText,
    this.label = 'Senha',
    required this.controller,
  });

  @override
  _PasswordFieldState createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;
  void updateObscureText() {
    obscureText = !obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      child: TextField(
        controller: widget.controller,
        style: const TextStyle(fontWeight: FontWeight.w600),
        obscureText: obscureText,
        decoration: InputDecoration(
          errorText: widget.errorText,
          labelText: widget.label, // Usar o parâmetro label aqui
          suffixIcon: IconButton(
            icon: Icon(
              obscureText
                  ? PhosphorIcons.eyeClosed // Ícone de olho fechado
                  : PhosphorIcons.eye, // Ícone de olho aberto
            ),
            onPressed: () {
              setState(() {
                updateObscureText(); // Atualiza o estado
              });
            },
          ),
          prefixIcon: const Icon(PhosphorIcons.lock),
        ),
      ),
    );
  }
}
