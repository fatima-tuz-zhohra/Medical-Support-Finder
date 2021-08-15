import 'package:flutter/material.dart';
import 'package:msf/authentication/auth_provider.dart';
import 'package:msf/authentication/login/loginpage.dart';
import 'package:msf/home/home_main/homepage.dart';
import 'package:provider/provider.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SplashPageScreen(),
      ),
    );
  }
}

class SplashPageScreen extends StatelessWidget {
  const SplashPageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        if (false) {
          return HomePage();
        } else {
          return LoginPage();
        }
      },
      child: Image.asset(
        'assets/images/round_hand.png',
        height: 140,
        width: 140,
      ),
    );
  }
}
