// ignore_for_file: avoid_print

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/auth_page_provider.dart';
import '../widgets/birth_date_picker.dart';
import '../widgets/scroll_behavior.dart';
import '../widgets/sex_menu.dart';
import '../widgets/terms_and_conditions.dart';

class AuthPage extends StatelessWidget {
  AuthPage({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void _validateRegistration(AuthPageProvider authPageProvider) {
    if (authPageProvider.birthDate.year == DateTime.now().year) {
      print('invalid birth date');
    } else if (authPageProvider.sex == null) {
      print('invalid sex');
    } else if (!authPageProvider.termsAccepted) {
      print('terms not accepted');
    } else {
      print('register successful');
    }
  }

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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Image.asset('assets/telehealth.png'),
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
                                    _validateRegistration(authPageProvider);
                                  } else {
                                    print('login success');
                                  }
                                } else {
                                  print('all fields are required');
                                }
                              },
                              style: ElevatedButton.styleFrom(
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
