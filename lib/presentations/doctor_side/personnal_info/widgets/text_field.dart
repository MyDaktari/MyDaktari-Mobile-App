import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String label;
  final int maxLines;
  final bool isNumber, isConst;
  final TextEditingController controller;
  const TextWidget(
      {super.key,
      required this.label,
      this.isConst = false,
      required this.controller,
      this.maxLines = 1,
      this.isNumber = false});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      decoration: InputDecoration(
        labelText: label,
        enabled: !isConst,
        filled: true,
        alignLabelWithHint: true,
        fillColor: Colors.black.withOpacity(0.08),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
