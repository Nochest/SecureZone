import 'package:flutter/material.dart';
import 'package:tesis_app/models/account.dart';
import 'package:tesis_app/services/account_service.dart';
import 'package:tesis_app/shared/widgets/dialogs.dart';

class AccountProvider extends ChangeNotifier {
  Account? _account;
  Account? get account => _account;
  set account(Account? value) {
    _account = value;
    notifyListeners();
  }

  String _phoneNumber = '';
  String get phoneNumber => _phoneNumber;
  set phoneNumber(String value) {
    _phoneNumber = value;
    notifyListeners();
  }

  Future<void> updatePassword(String newPassword, BuildContext context) async {
    await AccountService().updatePassword(newPassword).then((value) {
      if (value == 200) {
        Navigator.pop(context);
        Navigator.pop(context);
        AppDialogs.successDialog('Exito!', 'Contraseña actualizada.', context);
      } else {
        Navigator.pop(context);
        AppDialogs.errorDialog(
            'Error', 'No se ha podido actualizar la contraseña', context);
      }
    });
  }
}
