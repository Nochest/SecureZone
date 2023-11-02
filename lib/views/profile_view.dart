import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis_app/main.dart';
import 'package:tesis_app/providers/account_provider.dart';
import 'package:tesis_app/shared/routes/routes.dart';
import 'package:tesis_app/shared/widgets/custom_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  static const route = "profile_view";
  @override
  Widget build(BuildContext context) {
    final account = Provider.of<AccountProvider>(context).account!;
    return Scaffold(
      appBar: const CustomAppBar(
        height: 120.0,
        leading: Icon(Icons.arrow_back),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.blueGrey,
                child: account.imageEncoded == null
                    ? Image.asset('assets/ic_user_app.png')
                    : Image.memory(base64Decode(account.imageEncoded!)),
              ),
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Nombres',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  account.names,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Telefono',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  account.phome,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Correo electronico',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  account.email,
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 8),
            TextButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0))),
              onPressed: () {},
              child: const Text(
                'Comentarios',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0))),
              onPressed: () async {
                if (!await launchUrl(Uri.parse(
                    'https://www.youtube.com/@edwinjoelsalazarsaturno5564/featured'))) {
                  throw Exception('Could not launch ');
                }
              },
              child: const Text(
                'Consejos de seguridad',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0))),
              onPressed: () async {
                if (!await launchUrl(Uri.parse(
                    'https://www.youtube.com/@edwinjoelsalazarsaturno5564/featured'))) {
                  throw Exception('Could not launch ');
                }
              },
              child: const Text(
                'Tutoriales',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await localStorage.clear().then((value) =>
                      Navigator.pushNamedAndRemoveUntil(
                          context, SplashView.route, (route) => false));
                },
                child: const Text(
                  'Cerrar sesión',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
