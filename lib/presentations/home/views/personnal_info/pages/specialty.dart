import 'package:flutter/material.dart';

import '../../../../doctor_side/personnal_info/widgets/text_field.dart';

class Specialty extends StatelessWidget {
  const Specialty({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextWidget(label: 'Specialty')),
          SizedBox(height: 16),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextWidget(label: 'Experience in years')),
          SizedBox(height: 16),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextWidget(label: 'Location')),
          SizedBox(height: 16),
          Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: TextWidget(label: 'Career Overview', maxLines: 4)),
          SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextWidget(label: 'Consultation Fee'),
          ),
        ],
      ),
    );
  }
}
