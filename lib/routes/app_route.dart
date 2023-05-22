import 'package:flutter/material.dart';
import 'package:my_daktari/models/blog.dart';
import 'package:my_daktari/presentations/home/views/homeTab/views/symptomChecker/symptoms_samples.dart';

import '../mock/models/doctor_model.dart';
import '../presentations/auth/views/login_screen.dart';
import '../presentations/auth/views/sign_up_screen.dart';
import '../presentations/home/views/doctorsTab/views/doctor_profile_page.dart';
import '../presentations/home/views/homeTab/views/blog_screen.dart';
import '../presentations/home/views/homeTab/views/symptomChecker/symptom_checker.dart';
import '../presentations/home/views/home_page.dart';
import '../presentations/welcome_screen.dart';

const String authPage = 'authPage';
const String loginScreen = 'loginPage';
const String welcome = 'welcome';
const String homePage = 'homePage';
const String blogScreen = 'blogScreen';
const String doctorProfile = 'doctorProfile';
const String symptomChecker = 'symptomChecker';
const String symptomSamples = 'symptomSamples';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      case authPage:
        return MaterialPageRoute(builder: (_) => AuthPage());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case blogScreen:
        return MaterialPageRoute(
            builder: (_) => BlogScreen(blog: settings.arguments as BlogModel));
      case homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      case doctorProfile:
        return MaterialPageRoute(
            builder: (_) =>
                DoctorProfilePage(doctor: settings.arguments as DoctorModel));
      case symptomChecker:
        return MaterialPageRoute(builder: (_) => SymptomChecker());
      case symptomSamples:
        return MaterialPageRoute(
            builder: (_) => SymptomSamples(
                  bodyPartNotifier: settings.arguments as BodyPartNotifier,
                ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                appBar: AppBar(),
                body: Center(
                    child: Text('No route defined for ${settings.name}'))));
    }
  }
}
