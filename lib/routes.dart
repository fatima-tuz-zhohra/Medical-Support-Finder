import 'authentication/login/loginPage.dart';
import 'authentication/splash/splash.dart';
import 'category/blood/bloodBank_screen.dart';
import 'category/hospital/hospital_main_screen.dart';
import 'home/homepage.dart';

final appRoutes = {
  SplashPage.PATH : (context) => SplashPage(),
  LogInPage.PATH : (context) => LogInPage(),
  HomePage.PATH : (context) => HomePage(),
  HospitalMainScreen.PATH : (context) => HospitalMainScreen(),
  BloodBankScreen.PATH : (context) => BloodBankScreen(),
};