import 'package:auth/themes/colors.dart';
import 'package:flutter/material.dart';

class Bg extends StatelessWidget {
  final Widget child;

  const Bg({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  MyColors.primary550, // Cor inicial do gradiente
                  MyColors.primary400, // Cor final do gradiente
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'background.png',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: child,
          ),
        ],
      ),
    );
  }
}
