import 'package:flutter/material.dart';
import 'package:my_daktari/constants/routes/app_route.dart' as route;
import '/constants/constants.dart' as constants;

class AyaTab extends StatelessWidget {
  const AyaTab({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Expanded(
            child: Image.asset('assets/images/aya-half.png',
                fit: BoxFit.fitHeight)),
        Expanded(
          child: Container(
            width: size.width,
            decoration: const BoxDecoration(
                color: constants.primaryColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text('Hello, I\'m Aya',
                      style:
                          textTheme.titleLarge?.copyWith(color: Colors.white)),
                  Text(
                    'Your very own MyDaktari Assistant. I work 24/7 to enhance your MyDaktari experience and available at the touch of a button',
                    textAlign: TextAlign.center,
                    style: textTheme.titleMedium?.copyWith(color: Colors.white),
                  ),
                  ElevatedButton(
                      onPressed: () =>
                          Navigator.pushNamed(context, route.loginScreen),
                      child: const Text('Continue to Chat'))
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
