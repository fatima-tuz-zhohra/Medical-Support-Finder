import 'package:flutter/material.dart';
import 'package:msf/authentication/login/login_provider.dart';
import 'package:msf/authentication/splash/splash.dart';
import 'package:msf/theme/themes.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
