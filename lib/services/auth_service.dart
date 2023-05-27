import 'package:appwrite/appwrite.dart';

// Define a class for Appwrite authentication
class AppwriteAuth {
  // Define a static method for signing up a user
  static void signUp(String firstname, String lastname, String email,
      String username, String password) {
    // Initialize the Appwrite client
    Client client = Client();
    Account account = Account(client);

    // Set the Appwrite endpoint and project ID
    client
            .setEndpoint('https://cloud.appwrite.io/v1') // Your API Endpoint
            .setProject('6471c510263d6b4e5e77') // Your project ID
        ;

    // Call the Appwrite account.create method to sign up the user
    Future result = account.create(
      name: '$firstname $lastname',
      userId: username,
      email: email,
      password: password,
    );

    // Handle the response from the Appwrite API
    result.then((response) {
      print(response);
    }).catchError((error) {
      print(error.response);
    });
  }
}
