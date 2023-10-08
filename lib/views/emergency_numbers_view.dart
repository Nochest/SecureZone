import 'package:flutter/material.dart';
import 'package:tesis_app/shared/widgets/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyNumbersView extends StatefulWidget {
  const EmergencyNumbersView({super.key});
  static const route = 'emergency_numbers_view';

  @override
  State<EmergencyNumbersView> createState() => _EmergencyNumbersViewState();
}

class _EmergencyNumbersViewState extends State<EmergencyNumbersView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        height: 120.0,
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: [
            const Text(
              'Números de emergencias',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              onTap: () async {
                if (!await launchUrl(Uri.parse('tel:105'))) {
                  throw Exception('Could not launch ');
                }
              },
              leading: Image.asset(
                'assets/ic_user_app.png',
                width: 40,
                height: 40,
              ),
              title: const Text('Polocia'),
              trailing: const Icon(Icons.phone),
            ),
            const Divider(),
            ListTile(
              onTap: () async {
                if (!await launchUrl(Uri.parse('tel:911'))) {
                  throw Exception('Could not launch ');
                }
              },
              leading: Image.asset(
                'assets/ic_user_app.png',
                width: 40,
                height: 40,
              ),
              title: const Text('Emergencias'),
              trailing: const Icon(Icons.phone),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
