import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:tesis_app/models/survey.dart';
import 'package:tesis_app/providers/survey_provider.dart';
import 'package:tesis_app/shared/widgets/custom_app_bar.dart';

class SurveyView extends StatefulWidget {
  const SurveyView({super.key});
  static const route = 'survey_view';
  @override
  State<SurveyView> createState() => _SurveyViewState();
}

class _SurveyViewState extends State<SurveyView> {
  double rating = 0.0;
  final streetCtrl = TextEditingController();
  final contentCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        height: 140,
        leading: Icon(Icons.arrow_back),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height -
                  (kToolbarHeight + 140) -
                  32,
              child: Column(
                children: [
                  const Text(
                    'ENCUESTA',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.lightGreen,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Container(
                    width: MediaQuery.of(context).size.width / 6,
                    height: 10,
                    decoration: BoxDecoration(
                      color: Colors.lightGreen,
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Ingrese  la información correspondiente',
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextFormField(
                    controller: streetCtrl,
                    decoration: const InputDecoration(
                      label: Text('Calle'),
                      hintText: 'Ingrese calle',
                      suffixIcon: Icon(Icons.map),
                    ),
                  ),
                  const SizedBox(height: 48),
                  RatingBar.builder(
                    initialRating: 0,
                    minRating: 1,
                    direction: Axis.horizontal,
                    allowHalfRating: true,
                    itemCount: 5,
                    itemPadding: const EdgeInsets.symmetric(horizontal: 4),
                    itemBuilder: (context, _) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                    ),
                    onRatingUpdate: (r) {
                      rating = r;
                    },
                  ),
                  TextFormField(
                    controller: contentCtrl,
                    maxLines: 7,
                    decoration: const InputDecoration(
                      label: Text('Descripción'),
                      hintText: 'Ingrese descripción del robo',
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      if (streetCtrl.text.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Debe ingresar la calle.'),
                          backgroundColor: Colors.red,
                        ));
                        return;
                      }
                      final request = Survey(
                        street: streetCtrl.text,
                        rating: rating,
                        content: contentCtrl.text,
                      );
                      await context
                          .read<SurveyProvider>()
                          .addSurvey(context, request);
                    },
                    child: const Text('Enviar'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
