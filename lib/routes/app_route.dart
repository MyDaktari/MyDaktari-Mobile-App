import 'package:flutter/material.dart';

import '../mock/models/doctor_model.dart';
import '../presentations/auth/views/auth_page.dart';
import '../presentations/home/views/doctorsTab/views/doctor_profile_page.dart';
import '../presentations/home/views/homeTab/views/symptomChecker/symptom_checker.dart';
import '../presentations/home/views/home_page.dart';
import '../presentations/welcome/views/welcome.dart';

const String authPage = 'authPage';
const String welcome = 'welcome';
const String homePage = 'homePage';
const String doctorProfile = 'doctorProfile';
const String symptomChecker = 'symptomChecker';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      case authPage:
        return MaterialPageRoute(builder: (_) => AuthPage());
      case homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case doctorProfile:
        return MaterialPageRoute(
            builder: (_) =>
                DoctorProfilePage(doctor: settings.arguments as DoctorModel));
      case symptomChecker:
        return MaterialPageRoute(builder: (_) => SymptomChecker());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                appBar: AppBar(),
                body: Center(
                    child: Text('No route defined for ${settings.name}'))));
    }
  }
}
