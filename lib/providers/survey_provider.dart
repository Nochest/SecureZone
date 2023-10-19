import 'package:flutter/material.dart';
import 'package:tesis_app/models/survey.dart';
import 'package:tesis_app/services/survey_service.dart';

class SurveyProvider extends ChangeNotifier {
  Future<void> addSurvey(BuildContext context, Survey request) async {
    try {
      await SurveyService().add(request).then((value) {
        if (value) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Registro exitoso.'),
            backgroundColor: Colors.green,
          ));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Error al intetar registrar encuesta, asegurese de llenar todos los datos.'),
            backgroundColor: Colors.red,
          ));
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Error desconocido, vuelva a intentarlo.'),
        backgroundColor: Colors.red,
      ));
    }
  }
}
