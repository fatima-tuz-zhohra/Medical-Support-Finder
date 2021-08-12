import 'package:flutter/material.dart';
import 'package:msf/authentication/splash/splash.dart';
import 'package:msf/theme/themes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: lightTheme,
      home: SplashPage(),
    );
  }
}
