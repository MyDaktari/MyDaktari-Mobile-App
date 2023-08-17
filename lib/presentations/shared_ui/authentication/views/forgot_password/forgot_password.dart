import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_daktari/logic/bloc/shared_bloc/password_otp/password_otp_bloc.dart';
import 'package:my_daktari/logic/cubit/user_type/user_type_cubit.dart';
import 'package:my_daktari/presentations/shared_ui/authentication/views/forgot_password/password_otp_screen.dart';
import 'package:my_daktari/presentations/widgets/success_dialogue.dart';
import '../../../../../constants/colors.dart';

class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({super.key});
  final TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        appBar: AppBar(
            elevation: 0,
            leading: GestureDetector(
                onTap: () => Navigator.pop(context), child: BackButtonIcon())),
        body: SingleChildScrollView(
          child: BlocConsumer<PasswordOtpBloc, PasswordOtpState>(
              listener: (context, state) {
            if (state is PasswordOtpSet) {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) =>
                      PasswordOtpScreen(phoneNumber: phoneController.text)));
            }
            if (state is PasswordOtpLoadError) {
              successDialog(
                  context: context,
                  message: state.errorMessage,
                  title: 'My Daktari');
            }
          }, builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * .05),
                  const Text('Forgot Password',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  SizedBox(height: size.height * .01),
                  const Text('Enter your phone to recover the password',
                      style: TextStyle(fontSize: 17)),
                  SizedBox(height: size.height * .05),
                  Center(
                    child: new SvgPicture.asset('assets/svgs/password.svg',
                        height: size.height * .25,
                        width: 200.0,
                        allowDrawingOutsideViewBox: true),
                  ),
                  const SizedBox(height: 24),
                  TextField(
                      controller: phoneController,
                      enableSuggestions: false,
                      autocorrect: false,
                      keyboardType: TextInputType.phone,
                      maxLengthEnforcement: MaxLengthEnforcement.enforced,
                      maxLength: 10, // Set the maximum length to 10 characters
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                      style: TextStyle(
                          color: Colors.grey,
                          wordSpacing: 2,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(height: 24),
                  BlocBuilder<UserTypeCubit, UserTypeState>(
                    builder: (context, state) {
                      return Center(
                        child: ElevatedButton(
                            onPressed: () {
                              phoneController.text.isNotEmpty
                                  ? context.read<PasswordOtpBloc>().add(
                                      RequestPasswordOtp(
                                          phoneNumber: phoneController.text,
                                          userType: state.userType))
                                  : Fluttertoast.showToast(
                                      msg: 'Phone Number is required');
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  AppColor.primaryColor),
                              padding: MaterialStateProperty.all(
                                const EdgeInsets.symmetric(
                                    horizontal: 32, vertical: 12),
                              ),
                            ),
                            child: state is PasswordOtpLoading
                                ? const CupertinoActivityIndicator(
                                    color: Colors.white, radius: 10)
                                : const Text('Continue',
                                    style: TextStyle(fontSize: 16))),
                      );
                    },
                  ),
                ],
              ),
            );
          }),
        ));
  }
}
