import 'package:auth/themes/colors.dart';
import 'package:flutter/material.dart';

enum ButtonType { fill, outline, ghost }

enum ButtonSize { sm, md, lg } // Enum para tamanhos de botão

class PurpleButton extends StatelessWidget {
  final ButtonType type;
  final ButtonSize size; // Propriedade para o tamanho do botão
  final IconData? icon;
  final Icon? prefixIcon; // Propriedade para o prefixIcon
  final VoidCallback onPressed;
  final String text;

  const PurpleButton({
    this.type = ButtonType.fill,
    this.size = ButtonSize.md, // Valor padrão para o tamanho
    this.icon,
    required this.onPressed,
    required this.text,
    this.prefixIcon, // Adiciona prefixIcon aqui
  });

  // Define o estilo do botão (fill, outline, ghost)
  BoxDecoration _getBoxDecoration() {
    switch (type) {
      case ButtonType.fill:
        return BoxDecoration(
          border: Border.all(color: MyColors.primary550, width: 1),
          color: MyColors.primary550,
          borderRadius: BorderRadius.circular(8),
        );
      case ButtonType.outline:
        return BoxDecoration(
          border: Border.all(color: MyColors.primary400, width: 1),
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
      case ButtonType.ghost:
        return MyColors.primary550;
    }
  }

  // Define a cor do hover do botão
  Color _getHoverColor() {
    switch (type) {
      case ButtonType.fill:
        return MyColors.primary600;
      case ButtonType.outline:
        return MyColors.primary550.withOpacity(0.1);
      case ButtonType.ghost:
        return MyColors.primary550.withOpacity(0.2);
    }
  }

  Color _getStatusColor() {
    switch (type) {
      case ButtonType.fill:
        return MyColors.white100.withOpacity(0.1);
      case ButtonType.outline:
        return MyColors.primary550.withOpacity(0.1);
      case ButtonType.ghost:
        return MyColors.primary550.withOpacity(0.1);
    }
  }

  // Define a altura do botão com base no tamanho
  double _getButtonHeight() {
    switch (size) {
      case ButtonSize.sm:
        return 40; // Altura para botão pequeno
      case ButtonSize.md:
        return 56; // Altura para botão médio (padrão)
      case ButtonSize.lg:
        return 66; // Altura para botão grande
    }
  }

  // Define o tamanho do ícone com base no tamanho do botão
  double _getIconSize() {
    switch (size) {
      case ButtonSize.sm:
        return 18;
      case ButtonSize.md:
        return 22;
      case ButtonSize.lg:
        return 26;
    }
  }

  // Função que retorna a cor mais escura para o ícone
  Color _getIconColor() {
    switch (type) {
      case ButtonType.fill:
        return MyColors.primary300; // Cor mais escura do botão
      case ButtonType.outline:
      case ButtonType.ghost:
        return MyColors.primary400; // Um tom escuro para outline e ghost
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _getBoxDecoration(),
      child: MaterialButton(
        height: _getButtonHeight(), // Usa a altura definida
        highlightColor: _getStatusColor(),
        focusColor: _getStatusColor(),
        splashColor: _getStatusColor(),
        hoverColor: _getHoverColor(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        onPressed: onPressed,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 6.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (prefixIcon != null) ...[
                // Verifica se prefixIcon está presente
                Icon(
                  prefixIcon!.icon,
                  size: _getIconSize(), // Usa o tamanho do ícone definido
                  color: _getIconColor(), // Aplica a cor mais escura
                ),
                const SizedBox(
                    width: 8), // Espaçamento entre o prefixIcon e o texto
              ],
              if (icon != null) ...[
                Icon(
                  icon,
                  size: _getIconSize(), // Usa o tamanho do ícone definido
                  color: _getIconColor(), // Aplica a cor mais escura
                ),
                const SizedBox(width: 8),
              ],
              Text(
                text,
                style: Theme.of(context).primaryTextTheme.labelSmall?.copyWith(
                      color: _getForegroundColor(),
                      fontSize: _getFontSize(),
                    ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Define o tamanho da fonte do botão com base no tamanho
  double _getFontSize() {
    switch (size) {
      case ButtonSize.sm:
        return 14;
      case ButtonSize.md:
        return 16;
      case ButtonSize.lg:
        return 18;
    }
  }
}
