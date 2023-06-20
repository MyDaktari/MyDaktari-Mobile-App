// ignore_for_file: avoid_print
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_daktari/logic/bloc/auth_status/auth_status_bloc.dart';
import 'package:my_daktari/logic/bloc/doctor_bloc/doctor_appointments/doctor_appointments_bloc.dart';
import '../../../constants/constants.dart';
import 'package:my_daktari/constants/routes/route.dart' as route;

import '../../../constants/enums.dart';
import '../../../logic/bloc/authentication/authentication_bloc.dart';
import '../../../logic/bloc/doctor_bloc/doctor_patients/doctor_patients_bloc.dart';
import '../../../logic/cubit/user_type/user_type_cubit.dart';
import '../widgets/password_input.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(elevation: 0, backgroundColor: primaryColor),
      body: BlocBuilder<UserTypeCubit, UserTypeState>(
        builder: (context, userState) {
          return SingleChildScrollView(
            child: SafeArea(
                child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: size.height * .22,
                    width: size.width,
                    decoration: const BoxDecoration(color: primaryColor),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: Image.asset('assets/images/my_daktari.png')),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    child: Column(
                      children: [
                        SizedBox(height: 30),
                        Text('Hello There',
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(fontSize: 30)),
                        Text(
                          'Welcome Back!',
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
                        PasswordTextFormField(
                            passwordController: passwordController),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pushNamed(route.resetPassword);
                                  },
                                  child: Text('Forgot password?'))
                            ]),
                        const SizedBox(height: 15),
                        ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<AuthenticationBloc>().add(
                                    LoginUser(
                                        userType: userState.userType,
                                        username: emailController.text.trim(),
                                        password:
                                            passwordController.text.trim()));
                              } else {
                                print('all fields are required');
                              }
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(context).primaryColor,
                                fixedSize: Size(size.width * 0.8, 50),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: BlocConsumer<AuthenticationBloc,
                                  AuthenticationState>(
                                listener: (context, state) {
                                  if (state is AuthenticationLoaded) {
                                    Navigator.pop(context);
                                    context
                                        .read<AuthStatusBloc>()
                                        .add(CheckUserStatus());
                                    if (userState.userType == UserType.doctor) {
                                      context
                                          .read<DoctorAppointmentsBloc>()
                                          .add(LoadDoctorAppointments(
                                              doctorId: userId));
                                      context.read<DoctorPatientsBloc>().add(
                                          LoadDoctorPatients(doctorId: userId));
                                    }
                                  }
                                  if (state is AuthenticationError) {
                                    Fluttertoast.showToast(
                                        msg: state.errorMessage);
                                  }
                                },
                                builder: (context, state) {
                                  return state is AuthenticationLoading
                                      ? CupertinoActivityIndicator(
                                          color: Colors.white)
                                      : Text('Sign In',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16));
                                },
                              ),
                            )),
                        SizedBox(height: 15),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account yet? '),
                            TextButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context, route.signUpScreen);
                                },
                                child: Text('Sign Up'))
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
          );
        },
      ),
    );
  }
}
