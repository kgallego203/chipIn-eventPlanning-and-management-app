import 'package:appwrite/appwrite.dart';
import 'package:chip_in/features/events/models/attendees_model.dart';
import 'package:chip_in/features/events/models/event_model.dart';
import 'package:chip_in/constants/appwrite_constants.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class EventService {
  static final Client client = Client()
    ..setEndpoint(
        AppwriteConstants.endPoint) // Set the Appwrite server endpoint
    ..setProject(AppwriteConstants.projectId); // Set the Appwrite project ID
  static final Account account =
      Account(client); // Create an instance of the Account service
  static final Databases databases =
      Databases(client); // Create an instance of the Databases service

  Future<bool> createEvent(MyEventModel event) async {
    try {
      DateTime eventDateTime = DateTime.parse(
          '${event.eventDate} ${event.eventTime}'); // Parse the event date and time into a DateTime object
      String formattedDate = DateFormat('yyyy-MM-dd HH:mm:ss')
          .format(eventDateTime); // Format the date and time as a string

      // Generate a unique event ID using Uuid package
      String eventId = const Uuid().v4().replaceAll('-', '');

      await databases.createDocument(
        databaseId: AppwriteConstants.databaseId, // Specify the database ID
        collectionId:
            AppwriteConstants.eventsCollection, // Specify the collection ID
        documentId: eventId, // Assign the eventId to the documentId
        data: {
          'eventId': eventId,
          'title': event.title,
          'date': formattedDate,
          'location': event.location,
          'creatorId': event.creatorId,
          'description': event.description,
        }, // Set the data for the new event document
      );
      return true; // Event creation succeeded
    } catch (e) {
      print('Failed to create event: $e');
      return false; // Event creation failed
    }
  }

  static Future<bool> joinEvent(AttendeesModel attendee) async {
    try {
      String documentId = const Uuid().v4().replaceAll(
          '-', ''); // Generate a unique document ID using Uuid package
      await databases.createDocument(
        databaseId: AppwriteConstants.databaseId, // Specify the database ID
        collectionId:
            AppwriteConstants.attendeesCollection, // Specify the collection ID
        documentId: documentId, // Assign the generated documentId
        data: {
          'userId': attendee.userId,
          'eventId': attendee.eventId,
        }, // Set the data for the new attendee document
      );
      return true; // Attendee join succeeded
    } catch (e) {
      print('Failed to join event: $e');
      return false; // Attendee join failed
    }
  }

  Future<List<MyEventModel>> getMyCreatedEvents(String userId) async {
    List<MyEventModel> eventList = [];

    try {
      var response = await databases.listDocuments(
        databaseId: AppwriteConstants.databaseId, // Specify the database ID
        collectionId:
            AppwriteConstants.eventsCollection, // Specify the collection ID
      );

      if (response.documents.isNotEmpty) {
        for (var item in response.documents) {
          MyEventModel event = MyEventModel.fromJson(item
              .data); // Create an instance of MyEventModel from the document data
          if (event.creatorId == userId) {
            eventList.add(
                event); // Add the event to the list if the creator ID matches the provided user ID
          }
        }
      }
    } catch (e) {
      print('Failed to get events: $e');
    }
    return eventList; // Return the list of events created by the user
  }

  Future<List<MyEventModel>> getMyJoinedEvents(String userId) async {
    List<MyEventModel> eventList = [];

    try {
      var response = await databases.listDocuments(
        databaseId: AppwriteConstants.databaseId, // Specify the database ID
        collectionId:
            AppwriteConstants.attendeesCollection, // Specify the collection ID
      );

      if (response.documents.isNotEmpty) {
        for (var item in response.documents) {
          if (item.data['userId'] == userId) {
            String eventId = item.data['eventId'];
            var eventResponse = await databases.getDocument(
              databaseId:
                  AppwriteConstants.databaseId, // Specify the database ID
              collectionId: AppwriteConstants
                  .eventsCollection, // Specify the collection ID
              documentId: eventId, // Specify the document ID
            );
            if (eventResponse.data != null) {
              eventList.add(MyEventModel.fromJson(eventResponse
                  .data)); // Add the event to the list if it exists
            } else {
              print('Failed to get event with ID: $eventId');
            }
          }
        }
      }
    } catch (e) {
      print('Failed to get events: $e');
    }
    return eventList; // Return the list of events joined by the user
  }

  static Future<List<MyEventModel>> getAllEvents() async {
    List<MyEventModel> eventList = [];

    try {
      var response = await databases.listDocuments(
        databaseId: AppwriteConstants.databaseId, // Specify the database ID
        collectionId:
            AppwriteConstants.eventsCollection, // Specify the collection ID
      );

      if (response.documents.isNotEmpty) {
        for (var item in response.documents) {
          eventList.add(
            MyEventModel.fromJson(item
                .data), // Create an instance of MyEventModel from the document data and add it to the list
          );
        }
      }
    } catch (e) {
      print('Failed to get events: $e');
    }
    return eventList; // Return the list of all events
  }
}
