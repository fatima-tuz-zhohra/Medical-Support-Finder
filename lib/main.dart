import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:msf/authentication/login/login_provider.dart';
import 'package:msf/authentication/splash/splash.dart';
import 'package:msf/theme/themes.dart';
import 'package:provider/provider.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MSF());
}

class MSF extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      //home: SplashPage(),
      home: ChangeNotifierProvider<LoginProvider>(
        create: (context) {
          return LoginProvider();
        },
        child: SplashPage(),
      ),
    );
  }
}
