import 'package:appwrite/appwrite.dart';
import 'package:chip_in/constants/appwrite_constants.dart';

void main() {
  // Init SDK
  Client client = Client();
  Databases databases = Databases(client);

  client
          .setEndpoint(AppwriteConstants.endPoint) // Your API Endpoint
          .setProject(AppwriteConstants.projectId) // Your project ID
      ;
  Future result = databases.getDocument(
    databaseId: '[DATABASE_ID]',
    collectionId: '[COLLECTION_ID]',
    documentId: '[DOCUMENT_ID]',
  );

  result.then((response) {
    print(response);
  }).catchError((error) {
    print(error.response);
  });
}
