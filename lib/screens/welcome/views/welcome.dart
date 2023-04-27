import 'package:flutter/material.dart';

import '../../auth/widgets/scroll_behavior.dart';
import '/routes/app_route.dart' as route;

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ScrollConfiguration(
        behavior: MyBehavior(),
        child: ListView(
          physics: const ClampingScrollPhysics(),
          children: [
            const SizedBox(
              height: 200,
            ),
            const Center(
              child: Text(
                'Welcome to MyDaktari!',
                style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
              ),
            ),
            Image.asset(
              'assets/aya.png',
              height: 250,
            ),
            const SizedBox(
              height: 10,
            ),
            const Center(
              child: Text(
                'Meet Aya, your virtual assistant',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 1, 84, 186),
                ),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.fromLTRB(40, 12, 40, 10),
                child: Text(
                  'As a value-based healthcare solutions provider we consider ourselves health workers first and our mission is to become access equalizers in healthcare delivery in Kenya as well as the Great Lakes Region',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: SizedBox(
                height: 100,
                child: Column(
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 1, 84, 186),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(21))),
                        onPressed: () =>
                            Navigator.pushNamed(context, route.authPage),
                        child: const SizedBox(
                            width: 120,
                            child: Center(
                                child: Text(
                              'I am a Doctor',
                              style: TextStyle(fontSize: 16),
                            )))),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor:
                                const Color.fromARGB(255, 1, 84, 186),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(21))),
                        onPressed: () =>
                            Navigator.pushNamed(context, route.authPage),
                        child: const SizedBox(
                            width: 120,
                            child: Center(
                                child: Text(
                              'I am a Client',
                              style: TextStyle(fontSize: 16),
                            )))),
                  ],
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
