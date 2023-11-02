import 'dart:developer';

import 'package:appwrite/appwrite.dart' hide Account;
import 'package:tesis_app/main.dart';
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

      return result.documents.isNotEmpty
          ? Account.fromJson(result.documents.first.data)
          : null;
    } on AppwriteException catch (e) {
      log(e.message!);
      return null;
    }
  }

  Future<int> add(Account request) async {
    try {
      final doc = await ApiClient.database.createDocument(
          databaseId: Constants.database,
          collectionId: Constants.collectionAccountId,
          documentId: 'unique()',
          data: {
            'names': request.names,
            'email': request.email,
            'phone': request.phome,
            'password': request.pasword,
            'dni': request.dni,
            'imageEncoded': request.imageEncoded,
          });
      if (doc.$createdAt.isNotEmpty) {
        return 200;
      }
      return 400;
    } on AppwriteException catch (e) {
      log(e.message!);
      return 500;
    }
  }

  Future<int> updatePassword(String newPassword) async {
    final acc = Account.fromRawJson(localStorage.getString('user')!);
    try {
      final result = await ApiClient.database.listDocuments(
          databaseId: Constants.database,
          collectionId: Constants.collectionAccountId,
          queries: [
            Query.equal('email', acc.email),
            Query.equal('password', acc.pasword),
          ]);
      final id = result.documents.first.$id;

      final doc = await ApiClient.database.updateDocument(
          databaseId: Constants.database,
          collectionId: Constants.collectionAccountId,
          documentId: id,
          data: {
            'password': newPassword,
          });
      if (doc.$updatedAt.isNotEmpty) {
        return 200;
      }
      return 400;
    } on AppwriteException catch (e) {
      log(e.message!);
      return 500;
    }
  }

  Future<int> updateInfo(String name, String phone, String image) async {
    final acc = Account.fromRawJson(localStorage.getString('user')!);
    try {
      final result = await ApiClient.database.listDocuments(
          databaseId: Constants.database,
          collectionId: Constants.collectionAccountId,
          queries: [
            Query.equal('email', acc.email),
          ]);
      final id = result.documents.first.$id;

      final doc = await ApiClient.database.updateDocument(
          databaseId: Constants.database,
          collectionId: Constants.collectionAccountId,
          documentId: id,
          data: {
            'names': name,
            'phone': phone,
            'imageEncoded': image,
          });
      if (doc.$updatedAt.isNotEmpty) {
        return 200;
      }
      return 400;
    } on AppwriteException catch (e) {
      log(e.message!);
      return 500;
    }
  }
}
