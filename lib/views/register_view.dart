import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tesis_app/models/account.dart';
import 'package:tesis_app/providers/account_provider.dart';
import 'package:tesis_app/services/account_service.dart';
import 'package:tesis_app/shared/widgets/custom_app_bar.dart';
import 'package:tesis_app/shared/widgets/dialogs.dart';
import 'package:tesis_app/views/verification_view.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});
  static const route = 'register_view';
  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final ImagePicker _picker = ImagePicker();

  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();
  final dniCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final confirmPassCtrl = TextEditingController();

  XFile? pickedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        height: 140,
        leading: Icon(Icons.arrow_back),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () async {
                    pickedFile =
                        await _picker.pickImage(source: ImageSource.gallery);
                  },
                  child: CircleAvatar(
                    radius: 100,
                    backgroundColor: Colors.blueGrey,
                    child: pickedFile != null
                        ? Image.file(File(pickedFile!.path))
                        : Image.asset('assets/ic_user_app.png'),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: nameCtrl,
                  decoration: const InputDecoration(
                    label: Text('Nombre completo'),
                    hintText: 'Ingrese su nombre completo',
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: emailCtrl,
                  decoration: const InputDecoration(
                    label: Text('Correo'),
                    hintText: 'Ingrese su correo electronico',
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: phoneCtrl,
                  decoration: const InputDecoration(
                    label: Text('Telefono'),
                    hintText: 'Ingrese su Número de telefono',
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: dniCtrl,
                  decoration: const InputDecoration(
                    label: Text('DNI'),
                    hintText: 'Ingrese su DNI',
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: passCtrl,
                  decoration: const InputDecoration(
                    label: Text('Contraseña'),
                    hintText: 'Ingrese su contraseña',
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: confirmPassCtrl,
                  decoration: const InputDecoration(
                    label: Text('Repita contraseña'),
                    hintText: 'Ingrese  nuevamente su contraseña',
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async {
                    if (passCtrl.text != confirmPassCtrl.text) {
                      AppDialogs.errorDialog(
                          'Error', 'Las contraseñas deben coincidir', context);
                      return;
                    }
                    if (!RegExp(
                            r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
                        .hasMatch(passCtrl.text)) {
                      AppDialogs.errorDialog(
                          'Error',
                          '''Las contraseñas debe de tener:\n\nMinimo 8 caracteres.\nAl menos una letra mayuscula.\nUn número\nUn caracter especial
                          ''',
                          context,
                          size: MediaQuery.of(context).size.height / 4);
                      return;
                    }
                    final bites = await await pickedFile?.readAsBytes();

                    final request = Account(
                      names: nameCtrl.text,
                      email: emailCtrl.text,
                      phome: phoneCtrl.text,
                      pasword: passCtrl.text,
                      dni: dniCtrl.text,
                      imageEncoded:
                          bites == null ? '' : base64Encode(bites.toList()),
                    );

                    final r = await AccountService().add(request);
                    if (r != 200) {
                      AppDialogs.errorDialog('Error',
                          'Algo ocurrio, intente nuevamente.', context);
                    } else {
                      context.read<AccountProvider>().phoneNumber =
                          phoneCtrl.text;
                      AppDialogs.successDialog(
                          'Exito!', 'Cuenta registrada', context);
                      Navigator.pushNamed(context, VerificationView.route);
                    }
                  },
                  child: const Text('Registrarse!'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
