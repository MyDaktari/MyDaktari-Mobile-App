import 'package:flutter/material.dart';

import '../widgets/text_field.dart';

class Personal extends StatelessWidget {
  const Personal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextWidget(label: 'Full Name')),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Expanded(
                child: TextWidget(label: 'Gender'),
              ),
              SizedBox(width: 16),
              Expanded(child: TextWidget(label: 'Date of Birth')),
            ],
          ),
        ),
        SizedBox(height: 16),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: TextWidget(label: 'Email Address')),
        SizedBox(height: 16),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: TextWidget(label: 'Phone Number'),
        ),
      ],
    );
  }
}
