import 'package:flutter/material.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/constants/enums.dart';
import 'package:my_daktari/logic/cubit/user_type/user_type_cubit.dart';
import 'package:provider/provider.dart';

import '../constants/routes/route.dart' as route;

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
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
            flex: 40,
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
                  const SizedBox(height: 32),
                  SizedBox(
                    width: size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<UserTypeCubit>()
                            .switchToUser(userType: UserType.doctor);
                        Navigator.pushNamed(context, route.loginScreen);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: const EdgeInsets.all(15)),
                      child: const Text('I am a doctor',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: size.height * .02),
                  SizedBox(
                    width: size.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () {
                        context
                            .read<UserTypeCubit>()
                            .switchToUser(userType: UserType.client);
                        Navigator.pushNamed(context, route.homeScreen);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          padding: const EdgeInsets.all(15)),
                      child: const Text('I am a Client',
                          style: TextStyle(color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
