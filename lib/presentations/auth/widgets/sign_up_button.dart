import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:my_daktari/constants/route.dart' as route;

import '../../../constants/enums.dart';
import '../../../logic/bloc/authentication/authentication_bloc.dart';
import '../../../logic/cubit/sign_up_helper/sign_up_helper_cubit.dart';
import '../../../logic/cubit/user_type/user_type_cubit.dart';

class SignUpButton extends StatelessWidget {
  const SignUpButton(
      {super.key,
      required this.formKey,
      required this.addressController,
      required this.nameController,
      required this.phoneController,
      required this.emailController,
      required this.passwordController});
  final GlobalKey<FormState> formKey;
  final TextEditingController nameController,
      phoneController,
      emailController,
      addressController,
      passwordController;

  @override
  Widget build(BuildContext context) {
    final signUpHelperCubit = context.watch<SignUpHelperCubit>();
    final userTypeCubit = context.watch<UserTypeCubit>();
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
      onPressed: () {
        if (signUpHelperCubit.state.termsAccepted) {
          if (formKey.currentState!.validate()) {
            if (userTypeCubit.state.userType == UserType.doctor) {
              context.read<AuthenticationBloc>().add(RegisterDoctor(
                    name: nameController.text,
                    dob: signUpHelperCubit.state.birthDate,
                    gender: signUpHelperCubit.state.sex.name.toString(),
                    phone: phoneController.text.trim(),
                    email: emailController.text.trim(),
                    password: passwordController.text.toString(),
                  ));
            } else if (userTypeCubit.state.userType == UserType.client) {
              if (signUpHelperCubit.state.birthDate.toString().isNotEmpty &&
                  signUpHelperCubit.state.sex.name.toString().isNotEmpty) {
                context.read<AuthenticationBloc>().add(RegisterClient(
                      name: nameController.text,
                      dob: signUpHelperCubit.state.birthDate.toString(),
                      gender: signUpHelperCubit.state.sex.name.toString(),
                      address: addressController.text,
                      phone: phoneController.text.trim(),
                      email: emailController.text.trim(),
                      password: passwordController.text.toString(),
                    ));
              } else {
                Fluttertoast.showToast(msg: 'make sure all field are filled');
              }
            }
          } else {
            print('all fields are required');
          }
        } else {
          Fluttertoast.showToast(
              msg: 'Please accept the Terms & Conditions to continue');
        }
      },
      style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          fixedSize: Size(size.width * 0.8, 50),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18))),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            if (state is AuthenticationLoaded) {
              Navigator.pushNamed(context, route.signUpOtpScreen);
            }
            if (state is AuthenticationError) {
              Fluttertoast.showToast(msg: state.errorMessage);
            }
          },
          builder: (context, state) {
            return state is AuthenticationLoading
                ? CupertinoActivityIndicator(color: Colors.white)
                : Text('Sign Up',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 16));
          },
        ),
      ),
    );
  }
}
