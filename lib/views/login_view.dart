import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tesis_app/providers/account_provider.dart';
import 'package:tesis_app/services/account_service.dart';
import 'package:tesis_app/shared/widgets/custom_app_bar.dart';
import 'package:tesis_app/shared/widgets/dialogs.dart';
import 'package:tesis_app/views/report_map_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});
  static const route = 'login_view';
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailCotroller = TextEditingController();
  final passController = TextEditingController();
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
                child: Image.asset(
                  'assets/logo_app.png',
                  width: MediaQuery.of(context).size.width / 3,
                  height: 100,
                ),
              ),
              const SizedBox(height: 24),
              const Text(
                'Bienvenido de vuelta',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              TextFormField(
                controller: emailCotroller,
                decoration: const InputDecoration(
                  label: Text('Correo'),
                  hintText: 'Ingrese su correo',
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                obscureText: true,
                controller: passController,
                decoration: const InputDecoration(
                  label: Text('Contraseña'),
                  hintText: 'Ingrese su contraseña',
                ),
              ),
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {},
                  child: const Text('¿Olvidaste tu contraseña?'),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () async {
                  await AccountService()
                      .login(emailCotroller.text, passController.text)
                      .then((value) {
                    if (value != null) {
                      //TODO: SHARED PREFERENCES
                      context.read<AccountProvider>().account = value;
                      Navigator.pushNamed(context, ReportMapview.route);
                    } else {
                      AppDialogs.errorDialog(
                          'Error', 'Usuario no registrado', context);
                    }
                  });
                },
                //  Navigator.pushNamed(context, VerificationView.route),
                child: const Text('Ingresar'),
              ),
              const SizedBox(height: 8),
              TextButton(
                onPressed: () {},
                child: const Text('Crear una cuenta'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
