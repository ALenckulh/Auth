import 'package:auth/themes/colors.dart';
import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final Widget child;
  final double? width;
  final double? height;

  const CustomCard({
    super.key,
    required this.child,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: MyColors.white0,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: MyColors.primary200,
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1C2BCC).withOpacity(0.12),
            offset: const Offset(0, 0),
            blurRadius: 32,
            spreadRadius: 0,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: child,
      ),
    );
  }
}
