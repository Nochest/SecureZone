import 'dart:developer';

import 'package:appwrite/appwrite.dart';
import 'package:tesis_app/models/survey.dart';
import 'package:tesis_app/shared/config/api_client.dart';
import 'package:tesis_app/shared/config/cons.dart';

class SurveyService {
  Future<bool> add(Survey request) async {
    try {
      await ApiClient.database.createDocument(
        databaseId: Constants.database,
        collectionId: Constants.collectionSurveyId,
        documentId: 'unique()',
        data: {
          "street": request.street,
          "rating": request.rating,
          "content": request.content,
        },
      );
      return true;
    } on AppwriteException catch (e) {
      log(e.message!);
      return false;
    }
  }
}
