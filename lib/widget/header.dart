import 'package:auth/themes/colors.dart';
import 'package:auth/widget/Buttons/custom_circle_avatar.dart';
import 'package:auth/widget/Buttons/purple_button.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Header extends StatelessWidget implements PreferredSizeWidget {
  final bool showRepairButton; // Para controlar a exibição do botão de reparo
  final bool showAvatar; // Para controlar a exibição do avatar

  const Header({
    this.showRepairButton = true, // Exibir botão de reparo por padrão
    this.showAvatar = true, // Exibir avatar por padrão
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: const Border(
            bottom: BorderSide(
              color: MyColors.white0,
            ),
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(
              PhosphorIcons.coffee,
              size: 28,
              color: MyColors.primary550,
            ),
            Row(
              children: [
                if (showRepairButton) ...[
                  PurpleButton(
                    size: ButtonSize.sm,
                    onPressed: () => {},
                    text: "Reparos",
                    icon: PhosphorIcons.storefront,
                  ),
                  const SizedBox(width: 12),
                ],
                if (showAvatar) const CustomCircleAvatar(),
              ],
            )
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}

class HeaderWithLogo extends StatelessWidget implements PreferredSizeWidget {
  const HeaderWithLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: const Border(
            bottom: BorderSide(
              color: MyColors.white0,
            ),
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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(
              PhosphorIcons.coffee,
              size: 28,
              color: MyColors.primary550,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}
