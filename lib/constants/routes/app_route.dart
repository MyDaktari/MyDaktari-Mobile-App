import 'package:flutter/material.dart';
import 'package:my_daktari/models/appointment.dart';
import 'package:my_daktari/models/blog.dart';
import 'package:my_daktari/presentations/auth/views/otp_screen.dart';
import 'package:my_daktari/presentations/home/views/homeTab/views/symptomChecker/symptoms_samples.dart';

import '../../mock/models/doctor_model.dart';
import '../../presentations/auth/views/login_screen.dart';
import '../../presentations/auth/views/sign_up_screen.dart';
import '../../presentations/home/views/appointments/appointment_details.dart';
import '../../presentations/home/views/doctorsTab/views/doctor_profile_page.dart';
import '../../presentations/home/views/homeTab/views/blog_screen.dart';
import '../../presentations/home/views/homeTab/views/symptomChecker/symptom_checker.dart';
import '../../presentations/landing_screen.dart';
import '../../presentations/welcome_screen.dart';

const String signUpScreen = 'authPage';
const String loginScreen = 'loginPage';
const String otpScreen = 'otpPage';
const String welcome = 'welcome';
const String homePage = 'homePage';
const String blogScreen = 'blogScreen';
const String doctorProfile = 'doctorProfile';
const String symptomChecker = 'symptomChecker';
const String symptomSamples = 'symptomSamples';
const String appointmentDetails = 'appointmentDetails';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      case signUpScreen:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case loginScreen:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case otpScreen:
        return MaterialPageRoute(builder: (_) => OtpScreen());
      case blogScreen:
        return MaterialPageRoute(
            builder: (_) => BlogScreen(blog: settings.arguments as BlogModel));
      case appointmentDetails:
        return MaterialPageRoute(
            builder: (_) => AppointmentDetailsScreen(
                appointment: settings.arguments as AppointmentModel));
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
                bodyPartNotifier: settings.arguments as BodyPartNotifier));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                appBar: AppBar(),
                body: Center(
                    child: Text('No route defined for ${settings.name}'))));
    }
  }
}
