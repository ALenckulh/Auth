import 'package:auth/themes/colors.dart';
import 'package:flutter/material.dart';

class LinkButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const LinkButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,
      ),
      child: Text(
        text,
        style: Theme.of(context).primaryTextTheme.labelSmall?.copyWith(
              color: MyColors.primary550,
              decoration: TextDecoration.underline,
            ),
      ),
    );
  }
}
