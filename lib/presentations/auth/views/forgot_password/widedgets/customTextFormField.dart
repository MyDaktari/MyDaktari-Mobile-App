import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  bool phone;
  final TextEditingController controller;

  CustomTextFormField(
      {required this.labelText, required this.controller, this.phone = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: phone ? TextInputType.phone : TextInputType.text,
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return '$labelText is required';
        }
        return null;
      },
    );
  }
}
