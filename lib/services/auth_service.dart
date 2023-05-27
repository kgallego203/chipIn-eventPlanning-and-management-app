import 'package:chip_in/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';

class AppwriteAuth {
  static void signUp(String firstname, String lastname, String username,
      String email, String password) {
    Client client = Client();
    Account account = Account(client);

    client
            .setEndpoint('https://cloud.appwrite.io/v1') // Your API Endpoint
            .setProject('6471c510263d6b4e5e77') // Your project ID
        ;
    Future result = account.create(
      name: '$firstname $lastname',
      userId: username,
      email: email,
      password: password,
    );

    result.then((response) {
      print(response);
    }).catchError((error) {
      print(error.response);
    });
  }

  static void login(BuildContext context, String email, String password) {
    Client client = Client();
    Account account = Account(client);

    client
            .setEndpoint('https://cloud.appwrite.io/v1') // Your API Endpoint
            .setProject('6471c510263d6b4e5e77') // Your project ID
        ;
    Future result = account.createEmailSession(
      email: email,
      password: password,
    );

    result.then(
      (response) {
        print(response);

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

        const snackBar = SnackBar(
          content: Text('Login Failed'),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
    );
  }
}
