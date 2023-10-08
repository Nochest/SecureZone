import 'dart:developer';

import 'package:appwrite/appwrite.dart' hide Account;
import 'package:tesis_app/models/account.dart';
import 'package:tesis_app/shared/config/api_client.dart';
import 'package:tesis_app/shared/config/cons.dart';

class AccountService {
  Future<Account?> login(String email, String password) async {
    try {
      final result = await ApiClient.database.listDocuments(
          databaseId: Constants.database,
          collectionId: Constants.collectionAccountId,
          queries: [
            Query.equal('email', email),
            Query.equal('password', password),
          ]);
      return Account.fromJson(result.documents.first.data);
    } on AppwriteException catch (e) {
      log(e.message!);
      return null;
    }
  }
}
