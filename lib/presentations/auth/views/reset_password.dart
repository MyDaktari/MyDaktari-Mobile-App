import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../logic/bloc/forgot_password/forgot_password_bloc.dart';
import '../../../constants/routes/route.dart' as route;

class ResetPasswordScreen extends StatelessWidget {
  final TextEditingController tokenController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController emailController = TextEditingController();

  ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reset Password'),
        backgroundColor: Colors.red, // Set the app bar background color
        elevation: 0, // Remove app bar elevation
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
            listener: (context, state) {
              if (state is PasswordResetState) {
                Navigator.of(context).pushReplacementNamed(route.loginScreen);
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Reset Password',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 24),
                  _buildTextFormField(
                    labelText: 'OTP',
                    controller: tokenController,
                  ),
                  const SizedBox(height: 16.0),
                  _buildTextFormField(
                    labelText: 'Email',
                    controller: emailController,
                  ),
                  const SizedBox(height: 16.0),
                  _buildTextFormField(
                    labelText: 'New Password',
                    controller: newPasswordController,
                  ),
                  const SizedBox(height: 16.0),
                  _buildTextFormField(
                    labelText: 'Confirm Password',
                    controller: confirmPasswordController,
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      final String confirmPassword =
                          confirmPasswordController.text;
                      final String token = tokenController.text;
                      final String newPassword = newPasswordController.text;
                      final String email = emailController.text;

                      if (confirmPassword.isEmpty ||
                          token.isEmpty ||
                          newPassword.isEmpty ||
                          email.isEmpty) {
                        // Validate if any field is empty
                        _buildDialog(
                          context: context,
                          title: 'Error',
                          content: 'Please fill all fields',
                        );
                      } else {
                        context.read<ForgotPasswordBloc>().add(
                              ResetPasswordEvent(
                                token: token,
                                confirmPassword: confirmPassword,
                                newPassword: newPassword,
                                email: email,
                              ),
                            );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.red),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                      ),
                    ),
                    child: state is ForgotPasswordLoading
                        ? const CupertinoActivityIndicator(
                            color: Colors.white,
                            radius: 10,
                          )
                        : const Text(
                            'Reset Password',
                            style: TextStyle(fontSize: 16),
                          ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
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

  void _buildDialog({
    required BuildContext context,
    required String title,
    required String content,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
