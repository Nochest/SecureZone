import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:tesis_app/shared/config/api_client.dart';
import 'package:tesis_app/shared/config/cons.dart';

class AccountService {
  Future<void> login(String email, String password) async {
    try {
      await ApiClient.database.listDocuments(
          databaseId: Constants.database,
          collectionId: Constants.collectionAccountId,
          queries: [
            Query.equal('email', email),
            Query.equal('password', password),
          ]);
    } on AppwriteException catch (e) {
      log(e.message!);
    }
  }
}
