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
    // Initialize the client
    client
            .setEndpoint(AppwriteConstants.endPoint) // Your API Endpoint
            .setProject(AppwriteConstants.projectId) // Your project ID
        ;

    Databases databases = Databases(client);

    try {
      await databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.eventsCollection,
        documentId: ID.unique(),
        data: event.toJson(),
      );
      return true;
    } catch (e) {
      print('Failed to create event: $e');
      return false;
    }
  }

  // New function for fetching all events/documents
  Future<List<Event>> getAllEvents() async {
    List<Event> eventList = [];

    Databases databases = Databases(client);

    try {
      var response = await databases.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.eventsCollection,
      );

      if (response.documents.isNotEmpty) {
        for (var item in response.documents) {
          eventList.add(Event.fromJson(item.data));
        }
      }
    } catch (e) {
      print('Failed to get events: $e');
    }
    return eventList;
  }
}
