import 'package:chip_in/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';

class AppwriteAuth {
  // Method to sign up a new user
  static void signUp(String firstname, String lastname, String username,
      String email, String password) {
    // Create a new Appwrite client and account instance
    Client client = Client();
    Account account = Account(client);

    // Set the Appwrite endpoint and project ID
    client
            .setEndpoint('https://cloud.appwrite.io/v1') // Your API Endpoint
            .setProject('6471c510263d6b4e5e77') // Your project ID
        ;
    // Call the Appwrite account create method to sign up the user
    Future result = account.create(
      name: '$firstname $lastname',
      userId: username,
      email: email,
      password: password,
    );

    // Handle the result of the sign up request
    result.then((response) {
      print(response);
    }).catchError((error) {
      print(error.response);
    });
  }

  // Method to log in an existing user
  static void login(BuildContext context, String email, String password) {
    // Create a new Appwrite client and account instance
    Client client = Client();
    Account account = Account(client);

    // Set the Appwrite endpoint and project ID
    client
            .setEndpoint('https://cloud.appwrite.io/v1') // Your API Endpoint
            .setProject('6471c510263d6b4e5e77') // Your project ID
        ;
    // Call the Appwrite account createEmailSession method to log in the user
    Future result = account.createEmailSession(
      email: email,
      password: password,
    );

    // Handle the result of the login request
    result.then(
      (response) {
        print(response);

        // Show a snackbar with a success message and navigate to the home screen
        const snackBar = SnackBar(
          content: Text('Login Success'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              return const HomePage();
            },
          ),
        );
      },
    ).catchError(
      (error) {
        print(error.response);

        // Show a snackbar with an error message
        const snackBar = SnackBar(
          content: Text('Login Failed'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
  }
}
