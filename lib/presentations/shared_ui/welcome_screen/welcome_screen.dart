import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:my_daktari/constants/enums.dart';
import 'package:my_daktari/presentations/shared_ui/welcome_screen/widgets/usertype_button.dart';


class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      systemNavigationBarColor:
          Colors.black, // Customize the system navigation bar color
      systemNavigationBarIconBrightness:
          Brightness.light, // Set the toolbar icons to white
    ));
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 60,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/images/cover_photo.jpg'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
              ),
              child: SafeArea(
                child: const Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text('My Daktari',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 45,
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: size.height * .02),
                  const Text('Welcome to My Daktari',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: size.height * .02),
                  const Text(
                      'Connect with medical Professionals Anytime, Anywhere',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16, color: Colors.black54)),
                  UserTypeButton(
                      title: 'I am a Client', userType: UserType.client),
                  UserTypeButton(
                      title: 'I am a doctor', userType: UserType.doctor),
                  UserTypeButton(
                      title: 'I am a Health Supplier',
                      userType: UserType.supplier),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
