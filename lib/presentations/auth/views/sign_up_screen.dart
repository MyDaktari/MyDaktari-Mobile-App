// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/logic/cubit/user_type/user_type_cubit.dart';
import 'package:my_daktari/presentations/auth/widgets/sign_up_button.dart';
import '../../../constants/enums.dart';
import '../widgets/birth_date_picker.dart';
import '../widgets/sex_menu.dart';
import '../widgets/terms_and_conditions.dart';

// ignore: must_be_immutable
class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final userTypeCubit = context.watch<UserTypeCubit>();

    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          toolbarHeight: 0,
          backgroundColor: const Color.fromARGB(255, 1, 84, 186)),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: size.height * .20,
                width: size.width,
                decoration:
                    const BoxDecoration(color: Color.fromARGB(255, 1, 84, 186)),
                child: Padding(
                    padding: const EdgeInsets.only(top: 40.0),
                    child: Image.asset('assets/images/telehealth.png')),
              ),
              SizedBox(height: 10),
              Text('Create Account',
                  style: Theme.of(context)
                      .textTheme
                      .displaySmall!
                      .copyWith(fontSize: 30, fontWeight: FontWeight.w800)),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * .45,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: nameController,
                                validator: (val) {
                                  return val?.isEmpty ?? true
                                      ? 'name field should not be empty'
                                      : null;
                                },
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                    hintText: 'Full Name',
                                    hintStyle: const TextStyle(
                                        fontWeight: FontWeight.w300),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: size.width * .45,
                          child: Column(
                            children: [
                              TextFormField(
                                controller: phoneController,
                                validator: (val) {
                                  return val?.isEmpty ?? true
                                      ? 'name field should not be empty'
                                      : null;
                                },
                                keyboardType: TextInputType.phone,
                                decoration: InputDecoration(
                                    hintText: 'Phone Number',
                                    hintStyle: const TextStyle(
                                        fontWeight: FontWeight.w300),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15))),
                              ),
                              const SizedBox(height: 15),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                    Visibility(
                      visible: userTypeCubit.state.userType == UserType.client,
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          TextFormField(
                            controller: addressController,
                            validator: (val) {
                              return val?.isEmpty ?? true
                                  ? "field shouldn't be empty"
                                  : null;
                            },
                            decoration: InputDecoration(
                                hintText: 'Address',
                                hintStyle: const TextStyle(
                                    fontWeight: FontWeight.w300),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15))),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        BirthDatePicker(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [SexMenu(), SizedBox(height: 15)],
                          ),
                        )
                      ],
                    ),
                    TextFormField(
                      controller: passwordController,
                      validator: (val) {
                        return val?.isEmpty ?? true
                            ? 'Invalid password format'
                            : null;
                      },
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle:
                              const TextStyle(fontWeight: FontWeight.w300),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(height: 10),
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                      Text('Already have an account? '),
                      TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text('Sign In'))
                    ]),
                    const SizedBox(height: 10),
                    const TermsAndConditions(),
                    SignUpButton(
                        formKey: _formKey,
                        nameController: nameController,
                        phoneController: phoneController,
                        emailController: emailController,
                        addressController: addressController,
                        passwordController: passwordController)
                  ],
                ),
              )
            ],
          ),
        )),
      ),
    );
  }
}
