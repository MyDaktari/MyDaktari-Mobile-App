import 'package:flutter/material.dart';
import 'package:my_daktari/screens/home/views/home_page.dart';

import '../screens/auth/views/auth_page.dart';
import '../screens/welcome/views/welcome.dart';

const String authPage = 'authPage';
const String welcome = 'welcome';
const String homePage = 'homePage';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomePage());
      case authPage:
        return MaterialPageRoute(builder: (_) => AuthPage());
      case homePage:
        return MaterialPageRoute(builder: (_) => HomePage());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
