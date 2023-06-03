import 'package:flutter/material.dart';
import 'package:chip_in/themes/palette.dart';

// Function to show a date picker
Future<DateTime?> selectDate(BuildContext context, DateTime initialDate) async {
  return await showDatePicker(
    context: context,
    initialDate: initialDate,
    firstDate: DateTime.now(),
    lastDate: DateTime(2100),
  );
}

// Function to show a time picker
Future<TimeOfDay?> selectTime(
    BuildContext context, TimeOfDay initialTime) async {
  return await showTimePicker(
    context: context,
    initialTime: initialTime,
  );
}

// A TextFormField with common decorators and styles
TextFormField customFormField({
  required String labelText,
  required String? Function(String?) validator,
  required void Function(String?) onSaved,
}) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: labelText,
      labelStyle: const TextStyle(color: Pallete.neutral70),
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Pallete.neutral70),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Pallete.primary200),
      ),
    ),
    validator: validator,
    onSaved: onSaved,
  );
}
