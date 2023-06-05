import 'package:flutter/material.dart';

import 'package:my_daktari/models/appointment.dart';
import 'package:my_daktari/models/blog.dart';
import 'package:my_daktari/presentations/auth/views/otp_screen.dart';
import 'package:my_daktari/presentations/client_side/homeTab/views/ambulance/ambulance_screen.dart';
import 'package:my_daktari/presentations/client_side/homeTab/views/symptomChecker/symptoms_samples.dart';
import 'package:my_daktari/presentations/doctor_side/schedule/schedule_screen.dart';

import '../../models/doctor_profile_model.dart';
import '../../presentations/auth/views/login_screen.dart';
import '../../presentations/auth/views/sign_up_screen.dart';
import '../../presentations/doctor_side/appointments/appointment_details.dart';
import '../../presentations/client_side/doctorsTab/views/doctor_profile_page.dart';
import '../../presentations/client_side/homeTab/views/blog_screen.dart';
import '../../presentations/client_side/homeTab/views/pharmacy/pharmacy_screen.dart';
import '../../presentations/client_side/homeTab/views/symptomChecker/symptom_checker.dart';
import '../../presentations/doctor_side/charges/charges_screen.dart';
import '../../presentations/doctor_side/personnal_info/information_screen.dart';
import '../../presentations/landing_screen.dart';

import '../../presentations/welcome_screen.dart';

const String signUpScreen = 'authPage';
const String loginScreen = 'loginPage';
const String otpScreen = 'otpPage';
const String welcome = 'welcome';
const String charges = 'charges';
const String personalInfo = 'personalInfo';
const String schedule = 'schedule';
const String homePage = 'homePage';
const String ambulancePage = 'ambulance';
const String pharmacyPage = 'pharmacy';
const String blogScreen = 'blogScreen';
const String doctorProfile = 'doctorProfile';
const String symptomChecker = 'symptomChecker';
const String symptomSamples = 'symptomSamples';
const String appointmentDetails = 'appointmentDetails';
const String profile = "profile";

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
      case ambulancePage:
        return MaterialPageRoute(builder: (_) => AmbulanceScreen());
      case pharmacyPage:
        return MaterialPageRoute(builder: (_) => PharmacyScreen());
      case schedule:
        return MaterialPageRoute(builder: (_) => ScheduleScreen());
      case charges:
        return MaterialPageRoute(builder: (_) => ChargesScreen());
      case personalInfo:
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
            builder: (_) => DoctorProfilePage(
                doctor: settings.arguments as DoctorProfileModel));
      case symptomChecker:
        return MaterialPageRoute(builder: (_) => SymptomChecker());
      case symptomSamples:
        return MaterialPageRoute(
            builder: (_) => SymptomSamples(
                bodyPartNotifier: settings.arguments as BodyPartNotifier));

      case profile:
        return MaterialPageRoute(builder: (context) => PersonalDetailsScreen());

      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                appBar: AppBar(),
                body: Center(
                    child: Text('No route defined for ${settings.name}'))));
    }
  }
}
