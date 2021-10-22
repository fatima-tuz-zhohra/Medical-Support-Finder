import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:msf/authentication/bloc/user_bloc.dart';
import 'package:msf/authentication/splash/splash.dart';
import 'package:msf/routes.dart';
import 'package:msf/theme/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MSF());
}

class MSF extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<UserBloc>(
      create: (context) => UserBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: lightTheme,
        routes: appRoutes,
        initialRoute: SplashPage.PATH,
      ),
    );
  }
}
