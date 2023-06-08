import 'package:chip_in/constants/appwrite_constants.dart';

class MyEventModel {
  String eventId; // Unique identifier for the event
  String title; // Title of the event
  DateTime dateTime; // Date and time of the event
  String location; // Location of the event
  String description; // Description of the event
  String creatorId; // Unique identifier for the user who created the event

  MyEventModel({
    required this.eventId,
    required this.title,
    required this.dateTime,
    required this.location,
    required this.description,
    required this.creatorId,
  });

  // Create an Event from JSON data
  MyEventModel.fromJson(Map<String, dynamic> json)
      : eventId = json['id'] ??
            '', // If the 'id' key is null, set id to an empty string
        title = json['title'],
        dateTime = DateTime.parse(
            json['date']), // Parse the 'date' string into a DateTime object
        location = json['location'],
        description = json['description'],
        creatorId = json['creatorId'];

  // Convert our Event to JSON to make it easier when we store it in the database
  Map<String, dynamic> toJson() {
    return {
      'eventId': AppwriteConstants
          .eventsCollection, // Set the 'eventId' key to the eventsCollection constant from the AppwriteConstants class
      'title': title,
      'date': dateTime
          .toIso8601String(), // Convert the dateTime object to an ISO 8601 string
      'location': location,
      'description': description,
      'creatorId': creatorId,
    };
  }
}
