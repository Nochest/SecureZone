import 'package:flutter/material.dart';
import 'package:tesis_app/shared/routes/routes.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});
  static const route = 'splash_view';
  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            Image.asset(
              'assets/logo_app.png',
              width: MediaQuery.of(context).size.width / 3,
              height: 100,
            ),
            const SizedBox(height: 16),
            Image.asset(
              'assets/paisaje_app.png',
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 2,
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, LoginView.route),
              child: Text('Ingresar'),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {},
              child: const Text('Crear una cuenta'),
            ),
          ],
        ),
      ),
    );
  }
}