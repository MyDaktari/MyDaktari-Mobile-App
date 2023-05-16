// ignore_for_file: avoid_print

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../services/auth_page_provider.dart';
import '../widgets/birth_date_picker.dart';
import '../widgets/scroll_behavior.dart';
import '../widgets/sex_menu.dart';
import '../widgets/terms_and_conditions.dart';

// ignore: must_be_immutable
class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _validateRegistration(BuildContext context,
      {required AuthPageProvider authPageProvider}) {
    if (authPageProvider.birthDate.year == DateTime.now().year) {
      print('invalid birth date');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Your Birth Year Should Not Be This Year')));
      return false;
    } else if (authPageProvider.sex == null) {
      print('invalid sex');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text('Please Tell Us Your Gender')));
      return false;
    } else if (!authPageProvider.termsAccepted) {
      print('terms not accepted');
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
              'You will not be able to register if you do not accept the terms and conditions')));
      return false;
    } else {
      print('register successful');
      return true;
    }
  }

  TextEditingController nameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<AuthPageProvider>(builder: (context, authPageProvider, _) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          backgroundColor: const Color.fromARGB(255, 1, 84, 186),
        ),
        body: SafeArea(
            child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: size.height * .20,
                width: size.width,
                decoration:
                    const BoxDecoration(color: Color.fromARGB(255, 1, 84, 186)),
                child: Visibility(
                  visible: authPageProvider.isRegister,
                  replacement: Align(
                    alignment: Alignment.centerRight,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 40.0),
                      child: Image.asset('assets/images/my_daktari.png'),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Image.asset('assets/images/telehealth.png'),
                  ),
                ),
              ),
              Visibility(
                visible: authPageProvider.isRegister,
                child: Container(
                  height: size.height * .15,
                  width: size.width,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 238, 246, 244)),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 18.0),
                    child: Column(
                      children: const [
                        Text(
                          'Why Register?',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'It\'s Free!\nQuicker symptom checker services\nSchedule medication reminders\nSave articles',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w300,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ScrollConfiguration(
                    behavior: MyBehavior(),
                    child: ListView(
                      physics: const ClampingScrollPhysics(),
                      children: [
                        Visibility(
                          visible: authPageProvider.isRegister,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: nameController,
                                validator: (val) {
                                  return val?.isEmpty ?? true
                                      ? 'name field should not be empty'
                                      : null;
                                },
                                decoration: InputDecoration(
                                    hintText: 'Full Name',
                                    hintStyle: const TextStyle(
                                        fontWeight: FontWeight.w300),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                            ],
                          ),
                        ),
                        TextFormField(
                          controller: emailController,
                          validator: (val) {
                            return val?.isEmpty ?? true
                                ? 'incorrect email input format'
                                : null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle:
                                  const TextStyle(fontWeight: FontWeight.w300),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Visibility(
                            visible: authPageProvider.isRegister,
                            child: const BirthDatePicker()),
                        Visibility(
                            visible: authPageProvider.isRegister,
                            child: Column(children: [
                              SexMenu(size: size),
                              const SizedBox(
                                height: 15,
                              ),
                            ])),
                        TextFormField(
                          controller: passwordController,
                          validator: (val) {
                            return val?.isEmpty ?? true
                                ? 'This will not work'
                                : null;
                          },
                          decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle:
                                  const TextStyle(fontWeight: FontWeight.w300),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const TermsAndConditions(),
                        Padding(
                          padding:
                              const EdgeInsets.only(right: 80.0, left: 80.0),
                          child: ElevatedButton(
                              onPressed: () {
                                if (_formKey.currentState!.validate()) {
                                  if (authPageProvider.isRegister) {
                                    if (_validateRegistration(context,
                                        authPageProvider: authPageProvider)) {
                                      // authPageProvider.authenticate(User(
                                      //     authPageProvider.sex!,
                                      //     name: nameController.text.trim(),
                                      //     age: (DateTime.now().year -
                                      //         authPageProvider.birthDate.year),
                                      //     email: emailController.text.trim(),
                                      //     password: passwordController.text));
                                      // Navigator.pushReplacementNamed(
                                      //     context, routes.homePage);
                                    }
                                  } else {
                                    print('login success');

                                    // User user;
                                    // try {
                                    //   user = users
                                    //       .map((userJson) =>
                                    //           User.fromJson(userJson))
                                    //       .toList()
                                    //       .where((user) =>
                                    //           user.email ==
                                    //           emailController.text.trim())
                                    //       .first;

                                    //   if (passwordController.text ==
                                    //       user.password) {
                                    //     authPageProvider.authenticate(user);
                                    //     Navigator.pushReplacementNamed(
                                    //         context, routes.homePage);
                                    //   } else {
                                    //     ScaffoldMessenger.of(context)
                                    //         .showSnackBar(const SnackBar(
                                    //             backgroundColor: Colors.red,
                                    //             content: Text(
                                    //                 'Invalid Login Credentials')));
                                    //   }
                                    // } catch (e) {
                                    //   ScaffoldMessenger.of(context)
                                    //       .showSnackBar(const SnackBar(
                                    //           backgroundColor: Colors.red,
                                    //           content: Text(
                                    //               'Invalid Login Credentials')));
                                    // }
                                  }
                                } else {
                                  print('all fields are required');
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).primaryColor,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(18))),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  authPageProvider.isRegister
                                      ? 'Create an account'
                                      : 'Sign In',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16),
                                ),
                              )),
                        ),
                        Center(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: RichText(
                              text: TextSpan(
                                  text: authPageProvider.isRegister
                                      ? 'Already have an account?'
                                      : 'Need an account?',
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 13),
                                  children: [
                                    TextSpan(
                                        text: authPageProvider.isRegister
                                            ? ' Sign In.'
                                            : ' Sign up for MyDaktari',
                                        style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 1, 84, 186),
                                            fontSize: 14),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () => authPageProvider
                                              .setRegister(!authPageProvider
                                                  .isRegister)),
                                  ]),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        )),
      );
    });
  }
}
