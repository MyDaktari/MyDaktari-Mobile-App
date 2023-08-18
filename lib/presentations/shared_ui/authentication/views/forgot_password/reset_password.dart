import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/logic/cubit/user_type/user_type_cubit.dart';
import 'package:my_daktari/presentations/shared_ui/authentication/views/forgot_password/widedgets/customTextFormField.dart';
import 'package:my_daktari/presentations/widgets/success_dialogue.dart';

import '../../../../../constants/colors.dart';
import '../../../../../logic/bloc/shared_bloc/forgot_password/reset_password_bloc.dart';
import '../../../../../constants/route.dart' as route;

class ResetPasswordScreen extends StatelessWidget {
  ResetPasswordScreen({super.key, required this.userId});
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final String userId;
  @override
  Widget build(BuildContext context) {
    final userTypeCubit = context.watch<UserTypeCubit>();
    return Scaffold(
      appBar: AppBar(title: const Text('Reset Password'), elevation: 0),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
            listener: (context, state) {
              if (state is ResetPasswordLoaded) {
                successDialog(
                    context: context,
                    success: true,
                    route: route.loginScreen,
                    message: 'Password updated successfully',
                    title: 'My Daktari');
              }
            },
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 24),
                  CustomTextFormField(
                      labelText: 'New Password',
                      controller: newPasswordController),
                  const SizedBox(height: 16.0),
                  CustomTextFormField(
                      labelText: 'Confirm Password',
                      controller: confirmPasswordController),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      final String password = newPasswordController.text;
                      final String confirmPassword =
                          confirmPasswordController.text;
                      if (confirmPassword.isNotEmpty &&
                          password.isNotEmpty &&
                          userId.isNotEmpty) {
                        password == confirmPassword
                            ? context.read<ResetPasswordBloc>().add(
                                ResetPassword(
                                    userId: userId,
                                    userType: userTypeCubit.state.userType,
                                    newPassword: password))
                            : _buildDialog(
                                context: context,
                                title: 'Error',
                                content: " Passwords do not match",
                              );
                        // Validate if any field is empty
                      } else {
                        _buildDialog(
                          context: context,
                          title: 'Error',
                          content: 'Please fill all fields',
                        );
                      }
                    },
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(AppColor.primaryColor),
                      padding: MaterialStateProperty.all(
                        const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 12),
                      ),
                    ),
                    child: state is ResetPasswordLoading
                        ? const CupertinoActivityIndicator(
                            color: Colors.white, radius: 10)
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
