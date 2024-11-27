import 'package:auth/themes/colors.dart';
import 'package:flutter/material.dart';

enum ButtonType { fill, outline, ghost }

class RedButton extends StatelessWidget {
  final ButtonType type;
  final IconData? icon;
  final VoidCallback onPressed;
  final String text;

  const RedButton({
    this.type = ButtonType.fill,
    this.icon,
    required this.onPressed,
    required this.text,
    super.key,
  });

  // Define o estilo do botão (fill, outline, ghost)
  BoxDecoration _getBoxDecoration() {
    switch (type) {
      case ButtonType.fill:
        return BoxDecoration(
          color: MyColors.red100,
          borderRadius: BorderRadius.circular(8),
        );
      case ButtonType.outline:
        return BoxDecoration(
          border: Border.all(color: MyColors.red50, width: 1),
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        );
      case ButtonType.ghost:
        return BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(8),
        );
    }
  }

  // Define a cor do texto do botão
  Color _getForegroundColor() {
    switch (type) {
      case ButtonType.fill:
        return MyColors.primary100;
      case ButtonType.outline:
        return MyColors.red100;
      case ButtonType.ghost:
        return MyColors.red100;
    }
  }

  // Define a cor do hover do botão
  Color _getHoverColor() {
    switch (type) {
      case ButtonType.fill:
        return MyColors.red200;
      case ButtonType.outline:
        return MyColors.red100.withOpacity(0.1);
      case ButtonType.ghost:
        return MyColors.red100.withOpacity(0.2);
    }
  }

  Color _getStatusColor() {
    switch (type) {
      case ButtonType.fill:
        return MyColors.white100.withOpacity(0.2);
      case ButtonType.outline:
        return MyColors.red100.withOpacity(0.2);
      case ButtonType.ghost:
        return MyColors.red100.withOpacity(0.2);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _getBoxDecoration(),
      child: MaterialButton(
        height: 56,
        highlightColor: _getStatusColor(),
        focusColor: _getStatusColor(),
        splashColor: _getStatusColor(),
        hoverColor: _getHoverColor(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon),
              const SizedBox(width: 4),
            ],
            Text(
              text,
              style: Theme.of(context).primaryTextTheme.labelSmall?.copyWith(
                    color: _getForegroundColor(),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
