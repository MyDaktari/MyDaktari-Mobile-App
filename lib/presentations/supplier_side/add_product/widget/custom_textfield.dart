import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key, required this.hintText});
  final String hintText;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColor.lightGrey),
      child: TextField(
        decoration: InputDecoration(
            hintText: hintText,
            fillColor: AppColor.lightGrey,
            hintStyle: TextStyle(color: AppColor.blackText),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none)),
      ),
    );
  }
}
