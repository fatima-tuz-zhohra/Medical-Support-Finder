import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msf/authentication/bloc/user_bloc.dart';
import 'package:msf/authentication/login/loginPage.dart';
import 'package:msf/home/homepage.dart';

class SplashPage extends StatelessWidget {
  static const PATH = "/splash";

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
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserAuthenticatedState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomePage.PATH,
            (route) => false,
          );
        } else if (state is UserUnAuthenticatedState) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            LogInPage.PATH,
            (route) => false,
          );
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
