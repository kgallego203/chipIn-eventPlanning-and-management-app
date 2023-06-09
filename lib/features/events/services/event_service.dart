import 'package:appwrite/appwrite.dart';
import 'package:chip_in/features/events/models/attendees_model.dart';
import 'package:chip_in/features/events/models/event_model.dart';
import 'package:chip_in/constants/appwrite_constants.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class EventService {
  static final Client client = Client()
    ..setEndpoint(AppwriteConstants.endPoint)
    ..setProject(AppwriteConstants.projectId);
  static final Account account = Account(client);
  static final Databases databases = Databases(client);

  Future<bool> createEvent(MyEventModel event) async {
    try {
      DateTime eventDateTime =
          DateTime.parse('${event.eventDate} ${event.eventTime}');
      String formattedDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(eventDateTime);

      // Make the eventID exactly equal to the documentID
      String eventId = const Uuid().v4();

      await databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.eventsCollection,
        documentId: eventId,
        data: {
          'eventId': eventId,
          'title': event.title,
          'date': formattedDate,
          'location': event.location,
          'creatorId': event.creatorId,
          'description': event.description,
        },
      );
      return true;
    } catch (e) {
      print('Failed to create event: $e');
      return false;
    }
  }

  static Future<bool> joinEvent(AttendeesModel attendee) async {
    try {
      await databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.attendeesCollection,
        documentId: ID.unique(),
        data: {
          'userId': attendee.userId,
          'eventId': attendee.eventId,
        },
      );
      return true;
    } catch (e) {
      print('Failed to join event: $e');
      return false;
    }
  }

  Future<List<MyEventModel>> getMyCreatedEvents(String userId) async {
    List<MyEventModel> eventList = [];

    try {
      var response = await databases.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.eventsCollection,
      );

      if (response.documents.isNotEmpty) {
        for (var item in response.documents) {
          MyEventModel event = MyEventModel.fromJson(item.data);
          if (event.creatorId == userId) {
            eventList.add(event);
          }
        }
      }
    } catch (e) {
      print('Failed to get events: $e');
    }
    return eventList;
  }

  Future<List<MyEventModel>> getMyJoinedEvents(String userId) async {
    List<MyEventModel> eventList = [];

    try {
      var response = await databases.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.attendeesCollection,
      );

      if (response.documents.isNotEmpty) {
        for (var item in response.documents) {
          if (item.data['userId'] == userId) {
            String eventId = item.data['eventId'];
            var eventResponse = await databases.getDocument(
              databaseId: AppwriteConstants.databaseId,
              collectionId: AppwriteConstants.eventsCollection,
              documentId: eventId,
            );
            if (eventResponse.data != null) {
              eventList.add(MyEventModel.fromJson(eventResponse.data));
            } else {
              print('Failed to get event with ID: $eventId');
            }
          }
        }
      }
    } catch (e) {
      print('Failed to get events: $e');
    }
    return eventList;
  }

  static Future<List<MyEventModel>> getAllEvents() async {
    List<MyEventModel> eventList = [];

    try {
      var response = await databases.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.eventsCollection,
      );

      if (response.documents.isNotEmpty) {
        for (var item in response.documents) {
          eventList.add(
            MyEventModel.fromJson(item.data),
          );
        }
      }
    } catch (e) {
      print('Failed to get events: $e');
    }
    return eventList;
  }
}
