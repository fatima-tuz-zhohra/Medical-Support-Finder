import 'package:msf/category/blood/all_blood_request.dart';
import 'package:msf/profile/edit_profile.dart';

import 'authentication/login/loginPage.dart';
import 'authentication/splash/splash.dart';
import 'category/blood/bloodBank_screen.dart';
import 'category/blood/bloodDonor_screen.dart';
import 'category/blood/blood_request_screen.dart';
import 'category/hospital/hospital_main_screen.dart';
import 'home/homepage.dart';

final appRoutes = {
  SplashPage.PATH : (context) => SplashPage(),
  LogInPage.PATH : (context) => LogInPage(),
  HomePage.PATH : (context) => HomePage(),
  HospitalMainScreen.PATH : (context) => HospitalMainScreen(),
  BloodBankScreen.PATH : (context) => BloodBankScreen(),
  BloodDonorsScreen.PATH : (context) => BloodDonorsScreen(),
  AllBloodRequestScreen.PATH : (context) => AllBloodRequestScreen(),
  BloodRequestScreen.PATH : (context) => BloodRequestScreen(),
  EditProfileScreen.PATH : (context) => EditProfileScreen(),
};