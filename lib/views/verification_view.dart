import 'package:flutter/material.dart';
import 'package:tesis_app/shared/widgets/custom_app_bar.dart';

class VerificationView extends StatefulWidget {
  const VerificationView({super.key});
  static const route = 'verification_view';
  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(height: 120.0),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 24),
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  height: 100,
                  child: const Placeholder(),
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Ingrese el codigo de seguridad',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const Text(
                'Coloca los 4 digitos que se ha enviado a su correo',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('Reenviar codigo'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
