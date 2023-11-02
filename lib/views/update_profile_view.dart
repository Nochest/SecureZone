import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:tesis_app/models/account.dart';
import 'package:tesis_app/providers/account_provider.dart';
import 'package:tesis_app/services/account_service.dart';
import 'package:tesis_app/shared/routes/routes.dart';
import 'package:tesis_app/shared/widgets/custom_app_bar.dart';
import 'package:tesis_app/shared/widgets/dialogs.dart';

class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView({super.key});
  static const route = "update_profile_view";

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  final ImagePicker _picker = ImagePicker();

  final nameCtrl = TextEditingController();
  final phoneCtrl = TextEditingController();

  XFile? pickedFile;
  Account? acc;
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      acc = context.read<AccountProvider>().account!;
      nameCtrl.text = acc!.names;
      phoneCtrl.text = acc!.phome;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    acc = context.read<AccountProvider>().account!;

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
                    child: acc!.imageEncoded != null
                        ? Image.memory(base64Decode(acc!.imageEncoded!))
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
                const SizedBox(height: 8),
                TextFormField(
                  controller: phoneCtrl,
                  decoration: const InputDecoration(
                    label: Text('Telefono'),
                    hintText: 'Ingrese su Número de telefono',
                  ),
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () async {
                    final bites = await pickedFile?.readAsBytes();

                    final r = await AccountService().updateInfo(
                        nameCtrl.text,
                        phoneCtrl.text,
                        bites == null
                            ? acc!.imageEncoded!
                            : base64Encode(bites.toList()));
                    if (r != 200) {
                      AppDialogs.errorDialog('Error',
                          'Algo ocurrio, intente nuevamente.', context);
                    } else {
                      Navigator.pop(context);
                      AppDialogs.successDialog(
                          'Exito!', 'Cuenta actualizada', context);
                      Navigator.pushNamed(context, VerificationView.route);
                    }
                  },
                  child: const Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
