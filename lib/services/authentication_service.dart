import 'package:chip_in/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';
import 'package:chip_in/config/appwrite_config.dart';

class AppwriteAuth {
  static final Client client = Client()
    ..setEndpoint(AppwriteConfig.endPoint)
    ..setProject(AppwriteConfig.projectId);

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
}
