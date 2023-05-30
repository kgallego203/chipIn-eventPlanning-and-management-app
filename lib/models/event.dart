import 'package:chip_in/constants/appwrite_constants.dart';
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
      'eventId': AppwriteConstants.eventsCollection,
      'title': title,
      'date': dateTime.toIso8601String(),
      'location': location,
      'description': description,
      'time': "${time.hour}:${time.minute.toString().padLeft(2, '0')}",
    };
  }
}
