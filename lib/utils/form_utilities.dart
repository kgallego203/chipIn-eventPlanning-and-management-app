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

// A TextFormField with common decorators and styles (reusable)
TextFormField customFormField({
  required String labelText, // The label text for the form field
  required String? Function(String?)
      validator, // A function that takes a string and returns a string or null. Used for form field validation.
  required void Function(String?)
      onSaved, // A function that takes a string and returns void. Used to save the form field value.
}) {
  return TextFormField(
    decoration: InputDecoration(
      labelText: labelText, // Set the label text
      labelStyle:
          const TextStyle(color: Palette.neutral70), // Set the label text color
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
            color: Palette
                .neutral70), // Set the border color when the field is not focused
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(
            color: Palette
                .primary200), // Set the border color when the field is focused
      ),
    ),
    validator: validator, // Set the validation function
    onSaved: onSaved, // Set the save function
  );
}
