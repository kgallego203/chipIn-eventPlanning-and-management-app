import 'package:chip_in/constants/appwrite_constants.dart';

class Event {
  String id;
  String title;
  DateTime dateTime;
  String location;
  String description;
  String creatorId;
  List<String> attendeeIds;

  Event({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.location,
    required this.description,
    required this.creatorId,
    this.attendeeIds = const [],
  });

  Event.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? '',
        title = json['title'],
        dateTime = DateTime.parse(json['date']),
        location = json['location'],
        description = json['description'],
        creatorId = json['creatorId'],
        attendeeIds = json['attendeeIds'] != null
            ? List<String>.from(json['attendeeIds'])
            : [];

  Map<String, dynamic> toJson() {
    return {
      'eventId': AppwriteConstants.eventsCollection,
      'title': title,
      'date': dateTime.toIso8601String(),
      'location': location,
      'description': description,
      'creatorId': creatorId,
      'attendeeIds': attendeeIds,
    };
  }
}
