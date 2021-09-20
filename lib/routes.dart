import 'authentication/login/loginPage.dart';
import 'authentication/splash/splash.dart';
import 'home/homepage.dart';

final appRoutes = {
  SplashPage.PATH : (context) => SplashPage(),
  LogInPage.PATH : (context) => LogInPage(),
  HomePage.PATH : (context) => HomePage(),
};