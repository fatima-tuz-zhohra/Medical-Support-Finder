import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  LoginProvider();

  bool _isLoggedIn = false;

  bool isLoggedIn() => _isLoggedIn;

  void setLoggedInStatus(bool newStatus){
    _isLoggedIn = newStatus;
    notifyListeners();
  }
}
