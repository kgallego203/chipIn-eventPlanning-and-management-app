import 'package:appwrite/appwrite.dart';
import 'package:chip_in/features/events/models/event_model.dart';
import 'package:chip_in/constants/appwrite_constants.dart';
import 'package:intl/intl.dart';

/// TODO: THE EVENT ID SHOULD GENERATE A UNIQUE ID FOR EACH EVENT
/// WHAT'S HAPPENING RIGHT NOW IS THAT THE EVENT ID BEING PRINTED IS THE
/// EVENTS COLLECTION APPWRITE CONSTANT WHICH IS WRONG!

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
      // Convert the eventDate and eventTime properties to a DateTime object
      DateTime eventDateTime =
          DateTime.parse('${event.eventDate} ${event.eventTime}');

      // Format the DateTime object as a string in the desired format
      String formattedDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(eventDateTime);

      // Create a new document in the events collection with the provided event data
      await databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.eventsCollection,
        documentId: ID.unique(),
        data: {
          'eventId': ID.unique(),
          'title': event.title,
          'date':
              formattedDate, // Set the date attribute to the formatted date string
          'location': event.location,
          'creatorId': event.creatorId,
          'description': event.description,
        },
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
}
