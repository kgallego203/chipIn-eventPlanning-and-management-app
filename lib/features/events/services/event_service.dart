import 'package:appwrite/appwrite.dart';
import 'package:chip_in/features/events/models/event_model.dart';
import 'package:chip_in/constants/appwrite_constants.dart';

// This is a class EventService that contains methods for interacting with the Appwrite server
class EventService {
  // The constructor takes in a client, endpoint, and projectId as required parameters
  final Client client;
  final String endpoint;
  final String projectId;

  EventService({
    required this.client,
    required this.endpoint,
    required this.projectId,
  });

  // * Function for creating an event
  Future<bool> createEvent(MyEventModel event) async {
    // Initialize the client with the endpoint and project ID
    client
      ..setEndpoint(AppwriteConstants.endPoint) // Your API Endpoint
      ..setProject(AppwriteConstants.projectId); // Your project ID

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

  // * Function for getting all events
  Future<List<MyEventModel>> getAllEvents() async {
    List<MyEventModel> eventList = []; // Create an empty list of events

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
          eventList.add(MyEventModel.fromJson(item.data));
        }
      }
    } catch (e) {
      // If there was an error, log the error
      print('Failed to get events: $e');
    }
    return eventList;
  }

  // * Function for getting an event by ID and adding a user to the attendeeIds list
  Future<bool> joinEvent(String eventId, String userId) async {
    Databases databases = Databases(
        client); // create a Databases object using the initialized client. This object is used to interact with the Appwrite databases.
    try {
      var response = await databases.getDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.eventsCollection,
        documentId: eventId,
      );

      MyEventModel event = MyEventModel.fromJson(response.data);
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

  // * Function for getting events created by the user
  // TODO: If you have time, create a backend function that filters the events
  Future<List<MyEventModel>> getMyCreatedEvents(String userId) async {
    List<MyEventModel> eventList = []; // Create an empty list of events

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
}
