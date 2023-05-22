// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import '../../../constants/constants.dart';
import 'package:my_daktari/routes/app_route.dart' as route;

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // bool _validateRegistration(BuildContext context,
  //     {required AuthPageProvider authPageProvider}) {
  //   if (authPageProvider.birthDate.year == DateTime.now().year) {
  //     print('invalid birth date');
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         backgroundColor: Colors.red,
  //         content: Text('Your Birth Year Should Not Be This Year')));
  //     return false;
  //   } else if (authPageProvider.sex == null) {
  //     print('invalid sex');
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         backgroundColor: Colors.red,
  //         content: Text('Please Tell Us Your Gender')));
  //     return false;
  //   } else if (!authPageProvider.termsAccepted) {
  //     print('terms not accepted');
  //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //         backgroundColor: Colors.red,
  //         content: Text(
  //             'You will not be able to register if you do not accept the terms and conditions')));
  //     return false;
  //   } else {
  //     print('register successful');
  //     return true;
  //   }
  // }

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
          elevation: 0, backgroundColor: const Color.fromARGB(255, 1, 84, 186)),
      body: SafeArea(
          child: Form(
        key: _formKey,
        child: Column(
          children: [
            Container(
              height: size.height * .22,
              width: size.width,
              decoration:
                  const BoxDecoration(color: Color.fromARGB(255, 1, 84, 186)),
              child: Align(
                alignment: Alignment.centerRight,
                child: Padding(
                    padding: const EdgeInsets.only(right: 40.0),
                    child: Image.asset('assets/images/my_daktari.png')),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  children: [
                    SizedBox(height: 30),
                    Text(
                      'Hello There!',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontSize: 30),
                    ),
                    Text(
                      'Wellcome Back',
                      style: Theme.of(context)
                          .textTheme
                          .displaySmall!
                          .copyWith(fontSize: 30, color: primaryColor),
                    ),
                    SizedBox(height: 15),
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
                    const SizedBox(height: 15),
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
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                            onPressed: () {}, child: Text('Forget password ?')),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 80.0, left: 80.0),
                      child: ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                            } else {
                              print('all fields are required');
                            }
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Theme.of(context).primaryColor,
                              fixedSize: Size(120, 50),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(18))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'Sign In',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 16),
                            ),
                          )),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Don\'t have an account yet? '),
                        TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, route.authPage);
                          },
                          child: Text('Sign Up'),
                        ),
                      ],
                    ),
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
