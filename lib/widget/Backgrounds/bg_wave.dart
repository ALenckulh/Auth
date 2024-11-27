import 'package:flutter/material.dart';

class BgWave extends StatelessWidget {
  final Widget child;

  const BgWave({
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
          Align(
            alignment: Alignment.bottomCenter,
            child: Image.asset(
              'bg_wave.png',
              width: double.infinity,
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
