import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/logic/bloc/shared_bloc/otp/otp_bloc.dart';

import '../../../../../constants/colors.dart';
import '../../../../../constants/enums.dart';
import '../../../../../logic/bloc/shared_bloc/auth_status/auth_status_bloc.dart';
import '../../../../../logic/cubit/otp_timer/otp_timer_cubit.dart';
import '../../../../../logic/cubit/user_type/user_type_cubit.dart';
import '../../widgets/otp_input_field.dart';
import 'package:my_daktari/constants/route.dart' as route;

class SignUpOtpScreen extends StatelessWidget {
  SignUpOtpScreen({Key? key}) : super(key: key);
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();
  final TextEditingController _fieldSix = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final otpTimerCubit = context.watch<OtpTimerCubit>()..startTimer();
    final userTypeCubit = context.watch<UserTypeCubit>();
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: size.width * .05),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('One more thing...',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontSize: 32, fontWeight: FontWeight.w900)),
              Text(
                'We have sent a 6-digit code to \nyour mobile device.',
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2),
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
                    const Text('Don\'t receive your code?',
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
                          if (userPhoneNumber.isNotEmpty) {
                            context
                                .read<OtpBloc>()
                                .add(RequestOtp(phoneNumber: userPhoneNumber));
                            otpTimerCubit.resetTimer();
                          } else {
                            Fluttertoast.showToast(
                                msg: 'incorrect user number');
                          }
                        },
                        child: Text(
                          'Resend it',
                          style: TextStyle(
                            color: Colors.transparent,
                            shadows: [
                              Shadow(
                                  offset: Offset(0, -2),
                                  color: AppColor.primaryColor)
                            ],
                            decoration: TextDecoration.underline,
                            decorationColor: AppColor.primaryColor,
                          ),
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
                          context.read<OtpBloc>().add(VerifyOtp(
                              phoneNumber: userPhoneNumber,
                              otp: inputOTP,
                              isLogIn: false));
                        } else {
                          Fluttertoast.showToast(msg: '6-digit otp required!');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColor.primaryColor,
                        fixedSize: Size(size.width * .45, 45),
                      ),
                      child: BlocConsumer<OtpBloc, OtpState>(
                        listener: (context, state) {
                          if (state is OtpLoaded) {
                            if (userTypeCubit.state.userType ==
                                UserType.doctor) {
                              context
                                  .read<AuthStatusBloc>()
                                  .add(CheckUserStatus(showMessage: true));
                              Navigator.pushReplacementNamed(
                                  context, route.personalInfo);
                              // context.read<DoctorAppointmentsBloc>().add(
                              //     LoadDoctorAppointments(doctorId: userId));
                              // context
                              //     .read<DoctorPatientsBloc>()
                              //     .add(LoadDoctorPatients(doctorId: userId));
                            } else if (userTypeCubit.state.userType ==
                                UserType.client) {
                              context
                                  .read<AuthStatusBloc>()
                                  .add(CheckUserStatus(showMessage: true));
                              Navigator.pushReplacementNamed(
                                  context, route.welcomeMessageScreen);
                            } else if (userTypeCubit.state.userType ==
                                UserType.supplier) {
                              context
                                  .read<AuthStatusBloc>()
                                  .add(CheckUserStatus(showMessage: true));
                              Navigator.pushReplacementNamed(
                                  context, route.supplierHomeScreen);
                            }
                          }
                          if (state is OtpLoadingError) {
                            Fluttertoast.showToast(
                                    msg: 'invalid verification code')
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
                          if (state is OtpLoading) {
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
      ),
    );
  }
}
