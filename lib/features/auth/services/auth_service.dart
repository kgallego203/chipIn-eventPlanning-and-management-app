import 'package:appwrite/models.dart';
import 'package:chip_in/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:chip_in/constants/appwrite_constants.dart';

class AppwriteAuth {
  static final Client client = Client()
    ..setEndpoint(AppwriteConstants.endPoint)
    ..setProject(AppwriteConstants.projectId);

  static final Account account = Account(client);

  static Future<void> createUser(String firstname, String lastname,
      String username, String email, String password) async {
    try {
      await account.create(
        name: '$firstname $lastname',
        userId: username,
        email: email,
        password: password,
      );
      print('User created successfully');
    } catch (error) {
      print('Error creating user: $error');
      throw error;
    }
  }

  static Future<void> createSession(
      BuildContext context, String email, String password) async {
    try {
      await account.createEmailSession(
        email: email,
        password: password,
      );
      print('Session created successfully');
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } catch (error) {
      print('Error creating session: $error');
      throw error;
    }
  }

// This method is used to retrieve the ID of the currently logged in user. It does this by making a request to the Appwrite server to get the user data and then returning the ID of the user.
  static Future<String> getCreatorId() async {
    try {
      User response = await account.get();
      return response.$id;
    } catch (e) {
      print('Failed to get user ID: $e');
      throw e;
    }
  }
}
