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
}
