import 'package:appwrite/models.dart';
import 'package:chip_in/features/profile/models/user_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:chip_in/constants/appwrite_constants.dart';

// This is a static class AppwriteAuth that contains methods for user authentication
class UserService {
  // The code block initializes a Client and an Account object from the appwrite package,
  // which will be used for making API requests to the Appwrite server
  static final Client client = Client()
    ..setEndpoint(AppwriteConstants.endPoint)
    ..setProject(AppwriteConstants.projectId);
  static final Account account = Account(client);
  static final Databases databases = Databases(client);

  // * SIGN UP METHOD
  // This method creates a new user account with the given details
  // At the moment, this just creates an account in the console but it does not store it as a document
  // in the users colletion
  // TODO: After the user was created, it should automatically log them in (create session)
  static Future<void> createUser(String firstname, String lastname,
      String username, String email, String password) async {
    try {
      // Use the create method of the account object to create a new user with the given details
      await account.create(
        name: '$firstname $lastname',
        userId: username,
        email: email,
        password: password,
      );
      final UserProfileModel userProfile = UserProfileModel(
          name: '$firstname $lastname',
          email: email,
          userId: username,
          password: password,
          dateOfBirth: null,
          phoneNumber: null,
          profilePicture: null,
          location: null);

      await databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.usersCollection,
        documentId: ID.unique(),
        data: userProfile.toJson(),
      );
      print('User created successfully');
    } catch (error) {
      print('Error creating user: $error');
      throw error;
    }
  }

  // * LOGIN METHOD
  // This method creates a new session for the user with the given email and password
  static Future<void> createSession(
      BuildContext context, String email, String password) async {
    try {
      // Use the createEmailSession method of the account object to create a new session with the given email and password
      await account.createEmailSession(
        email: email,
        password: password,
      );
      print('Session created successfully');
    } catch (error) {
      print('Error creating session: $error');
      throw error;
    }
  }

  // * Method to get the currently logged in user
  // * This method retrieves the currently logged in user's ID
  static Future<String> getCreatorId() async {
    try {
      // Use the get method of the account object to retrieve the currently logged in user's details
      User response = await account.get();
      return response.$id; // Return the user's ID
    } catch (e) {
      print('Failed to get user ID: $e');
      throw e;
    }
  }

  // * LOGOUT METHOD
  // * This method deletes the current session, effectively logging the user out
  static Future<void> logout() async {
    try {
      // Use the deleteSession method of the account object to delete the current session
      await account.deleteSession(sessionId: 'current');
      print('Logged out successfully');
    } catch (e) {
      print('Failed to logout: $e');
      throw e;
    }
  }

// * Method to get the currently logged in user's name
// * This method retrieves the currently logged in user's details and returns their name
  static Future<String> getUserName() async {
    try {
      // Use the get method of the account object to retrieve the currently logged in user's details
      User response = await account.get();
      return response.name; // Return the user's name
    } catch (e) {
      print('Failed to get user name: $e');
      throw e;
    }
  }

  // * Magic URL Method
  // * This method sends a magic URL to the user's email address
  // * The user can then click on the link to log in without a password
  static Future<void> sendMagicURL(String userId, String email) async {
    try {
      // Use the createMagicURL method of the account object to send a magic URL to the user's email address
      await account.createMagicURLSession(
        userId: userId,
        email: email,
      );
      print('Magic URL sent successfully');
    } catch (e) {
      print('Failed to send magic URL: $e');
      throw e;
    }
  }
}
