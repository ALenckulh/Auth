import 'package:auth/themes/colors.dart';
import 'package:flutter/material.dart';

class CustomBigCard extends StatelessWidget {
  final Widget child;
  final double padding;

  const CustomBigCard({
    super.key,
    required this.child,
    this.padding = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyColors.white0,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40.0),
          topRight: Radius.circular(40.0),
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
