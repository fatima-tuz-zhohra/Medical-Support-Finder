import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider extends ChangeNotifier {
  AuthProvider() {
    _listenToAuthStateChanges();
  }

  StreamSubscription? _loginStateChangeSubscription;

  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  void _updateLoginStatus(newValue) {
    _isLoggedIn = newValue;
    notifyListeners();
    return;
  }

  void _listenToAuthStateChanges() {
    _loginStateChangeSubscription =
        FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User logged out');
        _updateLoginStatus(false);
      } else {
        print('User logged in');
        _updateLoginStatus(true);
      }
    });
  }

  @override
  void dispose() {
    _loginStateChangeSubscription?.cancel();
    super.dispose();
  }
}
