/* 

- Values that should never change.

*/
import 'package:appwrite/appwrite.dart';

class AppwriteConstants {
/* AUTH */

  // The ID of the Appwrite project used by the app
  static const String projectId = '6471c510263d6b4e5e77';

  // The endpoint URL of the Appwrite API used by the app
  static const String endPoint = 'https://cloud.appwrite.io/v1';

  // The ID of the Appwrite database used by the app
  static const String databaseId = '64734e007f78d838e9d4';

/* COLLECTIONS */

  // * The ID of the Appwrite collection used to store events
  /// This could be used to store details about the events in the app, such
  /// as the event name, date, time, location, description, the user who created
  /// the event, and any other information related to the event.
  static const String eventsCollection = '6475dd94e90d6c47cf0b';

  // * The ID of the Appwrite collection used to store users
  /// This could be used to store extra information about users that's
  /// not included in the Auth section, like their user preferences, profile pictures,
  /// or any additional details
  static const String usersCollection = '6475d82d54547e0be8c9';

  // * The ID of the Appwrite collection used to store attendees
  /// This could be used to store information about which users are attending
  /// which events. Each document could contain a reference to an event and a
  /// reference to a user, signifying that that user is attending that event.
  static const String attendeesCollection = '6475de40d97bb756a8fd';
}

class AppwriteService {
  static const String endPoint = AppwriteConstants.endPoint;
  static const String projectId = AppwriteConstants.projectId;

  static Client getClient() {
    final Client client = Client()
      ..setEndpoint(endPoint)
      ..setProject(projectId);
    return client;
  }
}
