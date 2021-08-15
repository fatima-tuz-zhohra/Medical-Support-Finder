import 'authentication/login/loginpage.dart';
import 'authentication/splash/splash.dart';
import 'home/home_main/homepage.dart';

final appRoutes = {
  SplashPage.PATH : (context) => SplashPage(),
  LoginPage.PATH : (context) => LoginPage(),
  HomePage.PATH : (context) => HomePage(),
};