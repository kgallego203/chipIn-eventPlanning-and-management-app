// Import the necessary packages and files
import 'package:chip_in/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';

/* The code defines a class AppwriteAuth that handles Appwrite authentication. 
The class has two methods: createUser for signing up a new user and createSession 
for logging in an existing user. The class also creates a new Appwrite client and 
account instance with the endpoint and project ID. */

class AppwriteAuth {
  // Create a new Appwrite client instance/object with the endpoint and project ID
  static final Client client = Client()
    ..setEndpoint('https://cloud.appwrite.io/v1')
    ..setProject('6471c510263d6b4e5e77');

  // Create a new Appwrite account instance with the client
  static final Account account = Account(client);

  // Method to sign up a new user
  static Future<void> createUser(String firstname, String lastname,
      String username, String email, String password) async {
    try {
      // Call the Appwrite account create method to sign up the user
      await account.create(
        name: '$firstname $lastname',
        userId: username,
        email: email,
        password: password,
      );
      // Print a success message if the user is signed up successfully
      print('User created successfully');
    } catch (error) {
      // Print an error message if there's an error signing up the user
      print('Error creating user: $error');
      throw error;
    }
  }

  // Method to log in an existing user
  static Future<void> createSession(
      BuildContext context, String email, String password) async {
    try {
      // Call the Appwrite account createEmailSession method to log in the user
      await account.createEmailSession(
        email: email,
        password: password,
      );
      // Print a success message if the user is logged in successfully
      print('Session created successfully');
      // Navigate to the home screen if the user is logged in successfully
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const HomePage(),
        ),
      );
    } catch (error) {
      // Print an error message if there's an error logging in the user
      print('Error creating session: $error');
      throw error;
    }
  }
}
