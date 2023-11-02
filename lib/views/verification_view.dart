import 'package:flutter/material.dart';
import 'package:tesis_app/shared/routes/routes.dart';
import 'package:tesis_app/shared/widgets/custom_app_bar.dart';
import 'package:tesis_app/shared/widgets/dialogs.dart';

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
              Row(
                children: [
                  Flexible(
                      child: TextFormField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                  )),
                  const SizedBox(width: 16),
                  Flexible(
                      child: TextFormField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                  )),
                  const SizedBox(width: 16),
                  Flexible(
                      child: TextFormField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                  )),
                  const SizedBox(width: 16),
                  Flexible(
                      child: TextFormField(
                    keyboardType: TextInputType.number,
                    textAlign: TextAlign.center,
                  )),
                ],
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          AppDialogs.successDialog(
              'Exito!', 'Cuenta verificada, inicie sesión', context);
          Navigator.pushNamed(context, LoginView.route);
        },
        child: const Icon(Icons.arrow_forward_rounded),
      ),
    );
  }
}
