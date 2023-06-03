import 'package:flutter/material.dart';
import 'package:my_daktari/constants/constants.dart';

class ClickableTime extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const ClickableTime({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: isSelected ? primaryColor : Colors.transparent,
        ),
        padding: const EdgeInsets.all(12),
        child: Text(
          text,
          style: TextStyle(color: isSelected ? Colors.white : Colors.black),
        ),
      ),
    );
  }
}
