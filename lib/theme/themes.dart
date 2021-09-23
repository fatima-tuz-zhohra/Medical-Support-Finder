import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final lightColorScheme = ColorScheme.light(
  primary: Color(0xff009688),
  secondary: Color(0xffff9800),
  surface: Colors.white,
  background: Colors.white,
  error: Color(0xffb00020),
  onPrimary: Colors.white,
  onSecondary: Colors.black,
  onSurface: Colors.black,
  onBackground: Colors.black,
  onError: Colors.white,
);

//final darkColorScheme = ColorScheme.dark();

final lightTheme = ThemeData.from(
  colorScheme: lightColorScheme,
  textTheme: GoogleFonts.montserratTextTheme(),
);
//final darkTheme = ThemeData.from(colorScheme: darkColorScheme);
