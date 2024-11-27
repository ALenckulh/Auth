import 'package:auth/themes/colors.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final ValueChanged<String?> onChanged;
  final String hintText;
  final IconData prefixIcon;
  final bool hasError;
  final String errorText;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hintText = 'Selecione um item',
    this.prefixIcon = Icons.person,
    this.hasError = false,
    this.errorText = 'Este campo é obrigatório',
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DropdownButtonFormField<String>(
          value: value,
          style: Theme.of(context).primaryTextTheme.bodyMedium,
          iconEnabledColor: MyColors.primary400,
          decoration: InputDecoration(
            filled: true,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: hasError ? MyColors.red200 : Colors.transparent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                color: hasError ? MyColors.red200 : Colors.transparent,
              ),
            ),
            prefixIcon: Icon(prefixIcon, color: MyColors.primary400),
          ),
          items: items.map((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(item),
            );
          }).toList(),
          onChanged: onChanged,
          hint: Text(
            hintText,
            style: const TextStyle(color: MyColors.primary400),
          ),
        ),
        if (hasError) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              const SizedBox(width: 14),
              Text(
                errorText,
                style: const TextStyle(
                  color: MyColors.red50,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
