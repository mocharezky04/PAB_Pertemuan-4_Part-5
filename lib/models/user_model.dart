import 'package:flutter/foundation.dart';

class UserModel extends ChangeNotifier {
  String _name = 'Guest User';
  String _phone = '';
  String _address = '';

  String get name => _name;
  String get phone => _phone;
  String get address => _address;

  void updateProfile({
    required String name,
    required String phone,
    required String address,
  }) {
    _name = name;
    _phone = phone;
    _address = address;
    notifyListeners();
  }
}
