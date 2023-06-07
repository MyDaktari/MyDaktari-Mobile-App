import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/logic/bloc/password_otp/password_otp_bloc.dart';
import 'package:my_daktari/logic/cubit/otp_timer/otp_timer_cubit.dart';

import 'package:my_daktari/logic/cubit/user_type/user_type_cubit.dart';
import 'package:my_daktari/presentations/auth/views/forgot_password/reset_password.dart';
import 'package:my_daktari/presentations/auth/widgets/otp_input_field.dart';

class PasswordOtpScreen extends StatelessWidget {
  PasswordOtpScreen({super.key, required this.email});
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  final TextEditingController _fieldSix = TextEditingController();
  final String email;
  @override
  Widget build(BuildContext context) {
    OtpTimerCubit otpTimerCubit = context.watch<OtpTimerCubit>()..startTimer();
    UserTypeCubit userTypeCubit = context.watch<UserTypeCubit>();
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          leading: GestureDetector(
              onTap: () => Navigator.pop(context), child: BackButtonIcon())),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: size.width * .05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Verification Code',
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    color: Colors.black)),
            SizedBox(height: size.height * .01),
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                style: TextStyle(fontSize: 18, letterSpacing: 2),
                children: [
                  TextSpan(
                      text: 'We have sent a 6-digit code to the email ',
                      style: TextStyle(color: Colors.black, fontSize: 15)),
                  TextSpan(
                    text: email,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                        fontSize: 15),
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * .05),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OtpInputField(_fieldOne, true),
                OtpInputField(_fieldTwo, false),
                OtpInputField(_fieldThree, false),
                OtpInputField(_fieldFour, false),
                OtpInputField(_fieldFive, false),
                OtpInputField(_fieldSix, false),
              ],
            ),
            SizedBox(height: size.height * .05),
            Center(
              child: Column(
                children: [
                  const Text('Didn\'t receive an email?',
                      textAlign: TextAlign.center),
                  SizedBox(height: size.height * .01),
                  Visibility(
                    visible: otpTimerCubit.state.counter == 0,
                    replacement: Text(
                      'Resend OTP in ${otpTimerCubit.state.counter} seconds',
                      textAlign: TextAlign.center,
                    ),
                    child: TextButton(
                      onPressed: () {
                        // Resend OTP request
                        if (email.isNotEmpty) {
                          context.read<PasswordOtpBloc>().add(
                              RequestPasswordOtp(
                                  email: email,
                                  userType: userTypeCubit.state.userType));
                          otpTimerCubit.resetTimer();
                        } else {
                          Fluttertoast.showToast(msg: 'Empty email');
                        }
                      },
                      child: const Text(
                        'Resend it',
                        style: TextStyle(
                            color: Colors.transparent,
                            shadows: [
                              Shadow(offset: Offset(0, -2), color: primaryColor)
                            ],
                            decoration: TextDecoration.underline,
                            decorationColor: primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: size.height * .05),
                  ElevatedButton(
                    onPressed: () {
                      String inputOTP = _fieldOne.text +
                          _fieldTwo.text +
                          _fieldThree.text +
                          _fieldFour.text +
                          _fieldFive.text +
                          _fieldSix.text;
                      if (inputOTP.length == 6) {
                        context.read<PasswordOtpBloc>().add(VerifyPasswordOtp(
                            email: email, PasswordOtp: inputOTP));
                      } else {
                        Fluttertoast.showToast(msg: '6-digit otp required!');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      fixedSize: Size(size.width * .45, 45),
                    ),
                    child: BlocConsumer<PasswordOtpBloc, PasswordOtpState>(
                      listener: (context, state) {
                        if (state is PasswordOtpLoaded) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) =>
                                  ResetPasswordScreen(userId: state.userId)));
                        }
                        if (state is PasswordOtpLoadError) {
                          Fluttertoast.showToast(msg: state.errorMessage)
                              .then((value) {
                            _fieldOne.clear();
                            _fieldTwo.clear();
                            _fieldThree.clear();
                            _fieldFour.clear();
                            _fieldFive.clear();
                            _fieldSix.clear();
                          });
                        }
                      },
                      builder: (context, state) {
                        if (state is PasswordOtpLoading) {
                          return CupertinoActivityIndicator(
                              color: Colors.white);
                        } else {
                          return Text(
                            'Verify',
                            style: Theme.of(context)
                                .textTheme
                                .headlineSmall!
                                .copyWith(color: Colors.white),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
