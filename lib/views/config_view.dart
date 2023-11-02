import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:sound_mode/permission_handler.dart';
import 'package:sound_mode/sound_mode.dart';
import 'package:sound_mode/utils/ringer_mode_statuses.dart';
import 'package:tesis_app/providers/account_provider.dart';
import 'package:tesis_app/shared/routes/routes.dart';
import 'package:tesis_app/shared/widgets/custom_app_bar.dart';
import 'package:tesis_app/shared/widgets/dialogs.dart';

enum Config {
  vibration,
  sound,
}

class ConfigurationView extends StatefulWidget {
  const ConfigurationView({super.key});
  static const route = "configuration_view";

  @override
  State<ConfigurationView> createState() => _ConfigurationViewState();
}

class _ConfigurationViewState extends State<ConfigurationView> {
  Config selected = Config.sound;

  final oldPassCtrl = TextEditingController();
  final newPassCtrl = TextEditingController();
  final newConfirmPassCtrl = TextEditingController();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) async {
      bool? isGranted = await PermissionHandler.permissionsGranted;
      if (!isGranted!) {
        await PermissionHandler.openDoNotDisturbSetting();
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final accountProvider = Provider.of<AccountProvider>(context);
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
            const Center(
              child: Text(
                'Configuración',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0))),
              onPressed: () =>
                  Navigator.pushNamed(context, UpdateProfileView.route),
              child: const Text(
                'Actualizar perfil',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            TextButton(
              style: ButtonStyle(
                  padding: MaterialStateProperty.all(const EdgeInsets.all(0))),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('¿Actualizar contraseña?'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('¿Deasea actualizar su contraseña?'),
                        const SizedBox(height: 4),
                        TextFormField(
                          obscureText: true,
                          controller: oldPassCtrl,
                          decoration: const InputDecoration(
                            label: Text('Contraseña actual'),
                            hintText: 'Ingrese su contraseña actual',
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextFormField(
                          obscureText: true,
                          controller: newPassCtrl,
                          decoration: const InputDecoration(
                            label: Text('Nueva contraseña'),
                            hintText: 'Ingrese su nueva contraseña',
                          ),
                        ),
                        const SizedBox(height: 4),
                        TextFormField(
                          obscureText: true,
                          controller: newConfirmPassCtrl,
                          decoration: const InputDecoration(
                            label: Text('Repetir contraseña'),
                            hintText: 'Ingrese nuevamente su nueva contraseña',
                          ),
                        ),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Cancelar'),
                      ),
                      TextButton(
                        onPressed: () async {
                          if (oldPassCtrl.text !=
                              accountProvider.account!.pasword) {
                            AppDialogs.errorDialog('Error',
                                'La contraseña no es correcta.', context);
                            return;
                          }
                          if (newPassCtrl.text != newConfirmPassCtrl.text) {
                            AppDialogs.errorDialog('Error',
                                'La  nueva contraseña no coincide.', context);
                            return;
                          }
                          await accountProvider.updatePassword(
                              newConfirmPassCtrl.text, context);
                        },
                        child: const Text('Actualizar '),
                      ),
                    ],
                  ),
                );
              },
              child: const Text(
                'Actualizar Contraseña',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            RadioListTile(
              value: Config.sound,
              groupValue: selected,
              onChanged: (value) async {
                setState(() {
                  selected = value!;
                });
                await SoundMode.setSoundMode(RingerModeStatus.normal);
              },
              contentPadding: const EdgeInsets.all(0),
              controlAffinity: ListTileControlAffinity.trailing,
              title: const Text(
                'Sonido',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            RadioListTile(
              value: Config.vibration,
              groupValue: selected,
              onChanged: (value) async {
                setState(() {
                  selected = value!;
                });
                await SoundMode.setSoundMode(RingerModeStatus.vibrate);
              },
              contentPadding: const EdgeInsets.all(0),
              controlAffinity: ListTileControlAffinity.trailing,
              title: const Text(
                'Vibración',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
