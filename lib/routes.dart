import 'authentication/login/loginPage.dart';
import 'authentication/splash/splash.dart';
import 'home/home_main/homepage.dart';

final appRoutes = {
  SplashPage.PATH : (context) => SplashPage(),
  LogInPage.PATH : (context) => LogInPage(),
  HomePage.PATH : (context) => HomePage(),
};