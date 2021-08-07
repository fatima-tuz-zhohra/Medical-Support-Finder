import 'package:flutter/material.dart';
import 'package:msf/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '',
      theme: ThemeData.from(colorScheme: ColorScheme.light(
        primary: Color(0xff009688),
        secondary: Color(0xff80cbc4),
      )),
      home: SplashPage(),
    );
  }
}