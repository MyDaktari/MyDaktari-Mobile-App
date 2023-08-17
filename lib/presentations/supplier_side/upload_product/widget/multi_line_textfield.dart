import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

class MultiLineTextField extends StatelessWidget {
  const MultiLineTextField(
      {super.key, required this.hintText, required this.controller});
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColor.lightGrey),
      child: TextField(
        controller: controller,
        maxLines: 5,
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
