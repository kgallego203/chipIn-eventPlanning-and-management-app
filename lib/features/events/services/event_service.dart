import 'package:appwrite/appwrite.dart';
import 'package:chip_in/features/events/models/event_model.dart';
import 'package:chip_in/constants/appwrite_constants.dart';

class EventService {
  final Client client;
  final String endpoint;
  final String projectId;

  EventService(
      {required this.client, required this.endpoint, required this.projectId});

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

  // New function for fetching all events/documents
  Future<List<Event>> getAllEvents() async {
    List<Event> eventList = [];

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
}
