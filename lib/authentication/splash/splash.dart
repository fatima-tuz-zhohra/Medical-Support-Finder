import 'package:flutter/material.dart';
import 'package:msf/authentication/login/loginpage.dart';

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
    Future.delayed(Duration(seconds: 1)).then((value) {
      Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context){
          return LoginPage();
      }
      )
    );
  }
  );
    return Image.asset(
      'assets/images/round_hand.png',
      height: 140,
      width: 140,
    );
  }
}
