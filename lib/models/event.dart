import 'package:chip_in/constants/appwrite_constants.dart';

class Event {
  String title;
  DateTime dateTime;
  String location;
  String description;
  String creatorId;

  Event({
    required this.title,
    required this.dateTime,
    required this.location,
    required this.description,
    required this.creatorId,
  });

  Map<String, dynamic> toJson() {
    return {
      'eventId': AppwriteConstants.eventsCollection,
      'title': title,
      'date': dateTime.toIso8601String(),
      'location': location,
      'description': description,
      'creatorId': creatorId,
    };
  }
}
