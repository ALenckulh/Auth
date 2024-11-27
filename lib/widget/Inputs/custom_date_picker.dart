import 'package:auth/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class CustomDatePicker extends StatefulWidget {
  final String buttonText;
  final IconData? icon;
  final Function(DateTime?) onDateSelected;
  final String errorText;
  final DateTime? initialDate;

  const CustomDatePicker({
    super.key,
    this.buttonText = 'Selecionar Data',
    this.icon = PhosphorIcons.calendar,
    required this.onDateSelected,
    this.errorText = 'Date is required',
    this.initialDate,
  });

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? selectedDate;

  @override
  void initState() {
    super.initState();
    selectedDate =
        widget.initialDate; // Initialize selectedDate with initialDate
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      locale: const Locale('pt', 'BR'),
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.onDateSelected(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define text color based on the selection state
    Color textColor = selectedDate != null
        ? MyColors.primary550 // Color when date is selected
        : MyColors.primary400; // Default color

    // Define fontWeight based on whether a date is selected
    FontWeight fontWeight = selectedDate != null
        ? FontWeight.w600 // Bold when date is selected
        : FontWeight.w500; // Normal when no date is selected

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        MaterialButton(
          elevation: 0,
          height: 56,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              color: widget.errorText.isNotEmpty
                  ? MyColors.red200
                  : Colors.transparent,
            ),
          ),
          color: MyColors.primary300,
          onPressed: () => _selectDate(context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                if (widget.icon != null) ...[
                  Icon(
                    widget.icon,
                    size: 24,
                    color: MyColors.primary400,
                  ),
                  const SizedBox(width: 8),
                ],
                Text(
                  selectedDate != null
                      ? DateFormat('dd/MM/yyyy').format(selectedDate!)
                      : widget.buttonText,
                  style:
                      Theme.of(context).primaryTextTheme.bodyMedium?.copyWith(
                            color: textColor,
                            fontWeight: fontWeight, // Apply dynamic fontWeight
                          ),
                ),
              ],
            ),
          ),
        ),
        // Error message
        if (widget.errorText.isNotEmpty) ...[
          const SizedBox(height: 4),
          Row(
            children: [
              const SizedBox(width: 14),
              Text(
                widget.errorText,
                style: Theme.of(context).primaryTextTheme.labelMedium?.copyWith(
                      color: MyColors.red50,
                    ),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
