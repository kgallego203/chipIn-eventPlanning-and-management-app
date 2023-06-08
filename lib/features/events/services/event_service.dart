import 'package:appwrite/appwrite.dart';
import 'package:chip_in/features/events/models/event_model.dart';
import 'package:chip_in/constants/appwrite_constants.dart';

// This is a class EventService that contains methods for interacting with the Appwrite server
class EventService {
  static final Client client = Client()
    ..setEndpoint(AppwriteConstants.endPoint)
    ..setProject(AppwriteConstants.projectId);
  static final Account account = Account(client);
  static final Databases databases = Databases(client);

  // * Function for creating an event
  Future<bool> createEvent(MyEventModel event) async {
    try {
      // Create a new document in the events collection with the provided event data
      await databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.eventsCollection,
        documentId: ID.unique(),
        data: event.toJson(),
      );
      return true;
    } catch (e) {
      // If there was an error, log the error and return false
      print('Failed to create event: $e');
      return false;
    }
  }

  // * Function for getting events created by the user
  Future<List<MyEventModel>> getMyCreatedEvents(String userId) async {
    List<MyEventModel> eventList = []; // Create an empty list of events

    try {
      // Get all documents in the events collection
      var response = await databases.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.eventsCollection,
      );

      // If there are documents, add them to the eventList
      if (response.documents.isNotEmpty) {
        for (var item in response.documents) {
          MyEventModel event = MyEventModel.fromJson(item.data);
          if (event.creatorId == userId) {
            eventList.add(event);
          }
        }
      }
    } catch (e) {
      // If there was an error, log the error
      print('Failed to get events: $e');
    }
    return eventList;
  }

  // * Function for getting all events
  static Future<List<MyEventModel>> getAllEvents() async {
    List<MyEventModel> eventList = []; // Create an empty list of events

    try {
      // Get all documents in the events collection
      var response = await databases.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.eventsCollection,
      );

      // If there are documents, add them to the eventList
      if (response.documents.isNotEmpty) {
        for (var item in response.documents) {
          eventList.add(
            MyEventModel.fromJson(item.data),
          );
        }
      }
    } catch (e) {
      // If there was an error, log the error
      print('Failed to get events: $e');
    }
    return eventList;
  }

  // NOTE - IN PROGRESS
  // * Function to join an event
  static Future<bool> joinEvent(String eventId, String userId) async {
    try {
      // Create a new document in the attendees collection with the provided event data
      await databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.attendeesCollection,
        documentId: ID.unique(),
        data: {
          'eventId': eventId,
          'userId': userId,
        },
      );
      return true;
    } catch (e) {
      // If there was an error, log the error and return false
      print('Failed to join event: $e');
      return false;
    }
  }
}
