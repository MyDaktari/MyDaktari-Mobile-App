import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String label;
  final int maxLines;
  const TextWidget({super.key, required this.label, this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
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
