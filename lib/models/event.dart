import 'package:flutter/material.dart';

class Event {
  String title;
  DateTime date;
  TimeOfDay time;
  String location;
  String description;

  Event({
    required this.title,
    required this.date,
    required this.time,
    required this.location,
    required this.description,
  });

  Map<String, dynamic> toJson() {
    final dateTime =
        DateTime(date.year, date.month, date.day, time.hour, time.minute);
    return {
      'title': title,
      'date': dateTime.toIso8601String(),
      'location': location,
      'description': description,
    };
  }
}
