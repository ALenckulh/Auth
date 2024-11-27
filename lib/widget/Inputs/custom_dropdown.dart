import 'package:auth/themes/colors.dart';
import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final String? value;
  final List<DropdownMenuItem<String>> items;
  final ValueChanged<String?> onChanged;
  final String hintText;
  final IconData prefixIcon;

  const CustomDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
    this.hintText = 'Selecione um item',
    this.prefixIcon = Icons.person,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      iconEnabledColor: MyColors.primary400,
      decoration: InputDecoration(
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.transparent),
        ),
        prefixIcon: Icon(prefixIcon, color: MyColors.primary400),
      ),
      items: items,
      onChanged: onChanged,
      hint: Text(
        hintText,
        style: const TextStyle(color: MyColors.primary400),
      ),
    );
  }
}
