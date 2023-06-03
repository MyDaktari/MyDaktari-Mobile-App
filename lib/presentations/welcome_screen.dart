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
            flex: 55,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: NetworkImage(
                        'https://www.safetyandhealthmagazine.com/ext/resources/images/news/healthcare/female-nurse.jpg?1494948091?1494948091'),
                    fit: BoxFit.cover),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25)),
              ),
              child: SafeArea(
                child: const Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'mydaktari',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
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
                  const Text('Welcome to MyDaktari',
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
                        Navigator.pushNamed(context, route.homePage);
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

  // Widget build(BuildContext context) {
  //   Size size = MediaQuery.of(context).size;
  //   return Scaffold(
  //     body: SafeArea(
  //         child: ScrollConfiguration(
  //       behavior: MyBehavior(),
  //       child: ListView(
  //         physics: const ClampingScrollPhysics(),
  //         children: [
  //           SizedBox(
  //             height: 200,
  //             child: Align(
  //               alignment: Alignment.centerRight,
  //               child: Padding(
  //                 padding: const EdgeInsets.only(right: 40.0),
  //                 child: Image.asset('assets/images/my_daktari_blue.png'),
  //               ),
  //             ),
  //           ),
  //           const Center(
  //             child: Text(
  //               'Welcome to MyDaktari!',
  //               style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
  //             ),
  //           ),
  //           Image.asset('assets/images/aya.png', height: 250),
  //           const SizedBox(height: 10),
  //           const Center(
  //             child: Text(
  //               'Meet Aya, your virtual assistant',
  //               style: TextStyle(
  //                 fontSize: 15,
  //                 fontWeight: FontWeight.bold,
  //                 color: Color.fromARGB(255, 1, 84, 186),
  //               ),
  //             ),
  //           ),
  //           const Center(
  //             child: Padding(
  //               padding: EdgeInsets.fromLTRB(40, 12, 40, 10),
  //               child: Text(
  //                 'As a value-based healthcare solutions provider we consider ourselves health workers first and our mission is to become access equalizers in healthcare delivery in Kenya as well as the Great Lakes Region',
  //                 textAlign: TextAlign.center,
  //                 style: TextStyle(
  //                   fontSize: 15,
  //                   fontWeight: FontWeight.w300,
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Padding(
  //             padding: const EdgeInsets.only(top: 20.0),
  //             child: SizedBox(
  //               height: 100,
  //               child: Column(
  //                 children: [
  //                   ElevatedButton(
  //                       style: ElevatedButton.styleFrom(
  //                           backgroundColor:
  //                               const Color.fromARGB(255, 1, 84, 186),
  //                           shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(21))),
  //                       onPressed: () {
  //                         context
  //                             .read<UserTypeCubit>()
  //                             .switchToUser(userType: UserType.doctor);
  //                         //authPageProvider.userType = UserType.doctor;
  //                         Navigator.pushNamed(context, route.loginScreen);
  //                       },
  //                       child: SizedBox(
  //                           width: size.width * .35,
  //                           child: Center(
  //                               child: Text(
  //                             'I am a Doctor',
  //                             style: TextStyle(fontSize: 16),
  //                           )))),
  //                   ElevatedButton(
  //                       style: ElevatedButton.styleFrom(
  //                           backgroundColor:
  //                               const Color.fromARGB(255, 1, 84, 186),
  //                           shape: RoundedRectangleBorder(
  //                               borderRadius: BorderRadius.circular(21))),
  //                       onPressed: () async {
  //                         context
  //                             .read<UserTypeCubit>()
  //                             .switchToUser(userType: UserType.client);
  //                         // authPageProvider.userType = UserType.client;
  //                         Navigator.pushNamed(context, route.homePage);
  //                       },
  //                       child: SizedBox(
  //                           width: size.width * .35,
  //                           child: Center(
  //                               child: Text('I am a Client',
  //                                   style: TextStyle(fontSize: 16))))),
  //                 ],
  //               ),
  //             ),
  //           )
  //         ],
  //       ),
  //     )),
  //   );
  // }
}
