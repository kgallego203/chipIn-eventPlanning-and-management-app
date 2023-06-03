import 'package:chip_in/constants/appwrite_constants.dart';

class Event {
  String title; // Event title
  DateTime dateTime; // Event date and time
  String location; // Event location
  String description; // Event description
  String creatorId; // Event creator's ID
  List<String>
      attendeeIds; // Will be used to fetch userIds when users would like to join an event

  Event({
    required this.title,
    required this.dateTime,
    required this.location,
    required this.description,
    required this.creatorId,
    this.attendeeIds = const [], // set the default value as an empty list
  });

/* These are two methods of the Event class in the event_model.dart file. */

  Event.fromJson(
      Map<String, dynamic>
          json) // The first method is fromJson which takes a Map<String, dynamic> as input and returns an Event object. This method is used to convert a JSON object to an Event object. It sets the values of the Event object's properties based on the values in the JSON object.
      : title = json['title'],
        dateTime = DateTime.parse(json['date']),
        location = json['location'],
        description = json['description'],
        creatorId = json['creatorId'],
        attendeeIds = List<String>.from(
            json['attendeeIds'] ?? []); // retrieve the list of attendees

  Map<String, dynamic> toJson() {
    // The second method is toJson which returns a Map<String, dynamic>. This method is used to convert an Event object to a JSON object. It creates a Map with the values of the Event object's properties and returns it.
    return {
      'eventId': AppwriteConstants.eventsCollection,
      'title': title,
      'date': dateTime.toIso8601String(),
      'location': location,
      'description': description,
      'creatorId': creatorId,
      'attendeeIds': attendeeIds, // add the list of attendees to the json
    };
  }
}
