import 'package:appwrite/appwrite.dart';
import 'package:chip_in/models/event.dart';
import 'package:chip_in/config/appwrite_config.dart';

class EventService {
  final Client client;
  final String endpoint;
  final String projectId;

  EventService(
      {required this.client, required this.endpoint, required this.projectId});

  Future<bool> createEvent(Event event) async {
    // Initialize the client
    client
            .setEndpoint(AppwriteConfig.endPoint) // Your API Endpoint
            .setProject(AppwriteConfig.projectId) // Your project ID
        ;

    Databases databases = Databases(client);

    try {
      await databases.createDocument(
        databaseId: '64734e007f78d838e9d4',
        collectionId: '64735198d9f3b0da5ed6',
        documentId: 'Your_Document_ID',
        data: event.toJson(),
      );
      return true;
    } catch (e) {
      print('Failed to create event: $e');
      return false;
    }
  }
}
