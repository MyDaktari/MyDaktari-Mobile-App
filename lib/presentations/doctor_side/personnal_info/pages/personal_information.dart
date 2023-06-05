// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../widgets/text_field.dart';

class Personal extends StatelessWidget {
  Personal({Key? key}) : super(key: key);

  TextEditingController nameController = TextEditingController();
  TextEditingController genderController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextWidget(label: 'Full Name', controller: nameController)),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child:
                    TextWidget(label: 'Gender', controller: genderController),
              ),
              SizedBox(width: 16),
              Expanded(
                  child: TextWidget(
                      label: 'Date of Birth', controller: dobController)),
            ],
          ),
        ),
        SizedBox(height: 16),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextWidget(
                label: 'Email Address', controller: emailController)),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: TextWidget(label: 'Phone Number', controller: phoneController),
        ),
      ],
    );
  }
}
