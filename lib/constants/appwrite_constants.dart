/* 

- Values that should never change 
- These values are used throughout the app to perform CRUD 
(Create, Read, Update, Delete) operations on the collections.

*/
class AppwriteConstants {
/* AUTH */

  // The ID of the Appwrite project used by the app
  static const String projectId = '6471c510263d6b4e5e77';

  // The endpoint URL of the Appwrite API used by the app
  static const String endPoint = 'https://cloud.appwrite.io/v1';

  // The ID of the Appwrite database used by the app
  static const String databaseId = '64734e007f78d838e9d4';

/* COLLECTIONS */

  // The ID of the Appwrite collection used to store events
  static const String eventsCollection = '6475dd94e90d6c47cf0b';

  // The ID of the Appwrite collection used to store users
  static const String usersCollection = '6475d82d54547e0be8c9';

  // The ID of the Appwrite collection used to store attendees
  static const String attendeesCollection = '6475de40d97bb756a8fd';

  // The ID of the Appwrite collection used to store notifications
  static const String notificationsCollection = '6475dedab82ae245b3eb';
}
