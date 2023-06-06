import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/presentations/auth/views/reset_password.dart';

import '../../../logic/bloc/forgot_password/forgot_password_bloc.dart';

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Forgot Password'),
          backgroundColor: Colors.red, // Set the app bar background color
          elevation: 0, // Remove app bar elevation
        ),
        body: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
            listener: (context, state) {
          if (state is TokenSentState) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ResetPasswordScreen(),
              ),
            );
          }
        }, builder: (context, state) {
          return Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 24),
                _buildTextFormField(
                  labelText: 'Email',
                  controller: emailController,
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    final String email = emailController.text;
                    context.read<ForgotPasswordBloc>().add(
                          SendTokenEvent(email: email),
                        );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    padding: MaterialStateProperty.all(
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    ),
                  ),
                  child: state is ForgotPasswordLoading
                      ? const CupertinoActivityIndicator(
                          color: Colors.white,
                          radius: 10,
                        )
                      : const Text(
                          'Send Token',
                          style: TextStyle(fontSize: 16),
                        ),
                ),
              ],
            ),
          );
        }));
  }

  TextFormField _buildTextFormField({
    required String labelText,
    required TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return '$labelText is required';
        }
        return null;
      },
    );
  }

  // void _buildDialog({
  //   required BuildContext context,
  //   required String title,
  //   required String content,
  // }) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(title),
  //         content: Text(content),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('OK'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
