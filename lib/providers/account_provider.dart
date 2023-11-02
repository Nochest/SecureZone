import 'package:flutter/material.dart';
import 'package:tesis_app/models/account.dart';

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
}
