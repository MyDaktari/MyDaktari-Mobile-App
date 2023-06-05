// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../widgets/text_field.dart';

class Specialty extends StatelessWidget {
  Specialty({Key? key}) : super(key: key);
  TextEditingController specialtyController = TextEditingController();
  TextEditingController expController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController careerController = TextEditingController();
  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextWidget(
                  label: 'Specialty', controller: specialtyController)),
          SizedBox(height: 16),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextWidget(
                  label: 'Experience in years', controller: expController)),
          SizedBox(height: 16),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextWidget(
                  label: 'Location', controller: locationController)),
          SizedBox(height: 16),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextWidget(
                  label: 'Career Overview',
                  maxLines: 4,
                  controller: careerController)),
          SizedBox(height: 16),
          // Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 16.0),
          //   child: TextWidget(label: 'Consultation Fee'),
          // ),
        ],
      ),
    );
  }
}
