import 'package:flutter/material.dart';
import 'package:my_daktari/presentations/doctor_side/schedule/widgets/select_time_dialog.dart';

class TimeDropDown extends StatelessWidget {
  final String initialValue;
  final List<String> timeIntervals;
  final ValueChanged<String> onPressed;

  const TimeDropDown(
      {super.key,
      required this.initialValue,
      required this.timeIntervals,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        selectTimeDialog(
            context: context, initialValue: initialValue, onPressed: onPressed);
      },
      child: Row(
        children: [
          Text(initialValue, style: TextStyle(color: Colors.black)),
          const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.black),
        ],
      ),
    );
  }
}
