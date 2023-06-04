import 'package:appwrite/appwrite.dart';
import 'package:chip_in/features/events/models/event_model.dart';
import 'package:chip_in/constants/appwrite_constants.dart';

class EventService {
  final Client client;
  final String endpoint;
  final String projectId;

  EventService(
      {required this.client, required this.endpoint, required this.projectId});

// * FUNCTION FOR CREATING AN EVENT

  Future<bool> createEvent(Event event) async {
    // Initialize the client with the endpoint and project ID
    client
            .setEndpoint(AppwriteConstants.endPoint) // Your API Endpoint
            .setProject(AppwriteConstants.projectId) // Your project ID
        ;

    // Create a Databases object using the initialized client
    Databases databases = Databases(client);

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

// * FUNCTION FOR GETTING ALL EVENTS
  // Future<List<Event>> means that this function will return a list of events in the future
  Future<List<Event>> getAllEvents() async {
    List<Event> eventList = []; // Create an empty list of events

    // Create a Databases object using the initialized client
    Databases databases = Databases(client);

    try {
      // Get all documents in the events collection
      var response = await databases.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.eventsCollection,
      );

      // If there are documents, add them to the eventList
      if (response.documents.isNotEmpty) {
        for (var item in response.documents) {
          eventList.add(Event.fromJson(item.data));
        }
      }
    } catch (e) {
      // If there was an error, log the error
      print('Failed to get events: $e');
    }
    return eventList;
  }

// * FUNCTION FOR GETTING AN EVENT BY ID
  Future<bool> joinEvent(String eventId, String userId) async {
    Databases databases = Databases(
        client); // create a Databases object using the initialized client. This object is used to interact with the Appwrite databases.
    try {
      var response = await databases.getDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.eventsCollection,
        documentId: eventId,
      );

      Event event = Event.fromJson(response.data);
      // Add the user to the list of attendeeIds if they're not already in it
      if (!event.attendeeIds.contains(userId)) {
        event.attendeeIds.add(userId);
        await databases.updateDocument(
          databaseId: AppwriteConstants.databaseId,
          collectionId: AppwriteConstants.eventsCollection,
          documentId: eventId,
          data: event.toJson(),
        );
      }
      return true;
    } catch (e) {
      print('Failed to get event: $e');
      return false;
    }
  }
}
