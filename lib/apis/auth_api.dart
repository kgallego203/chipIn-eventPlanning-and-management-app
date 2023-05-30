// import 'package:appwrite/appwrite.dart';

// class AuthAPI {
//   final Client _client;

//   AuthAPI(this._client);

//   Future<String> getCreatorId() async {
//     Account account = Account(_client);
//     try {
//       Response response = await account.get();
//       return response.data['\$id'];
//     } on AppwriteException catch (e, s) {
//       print('Failed to get user ID: ${e.message}');
//       print('Stack trace: $s');
//       throw e;
//     }
//   }

//   // Other authentication-related methods...
// }
