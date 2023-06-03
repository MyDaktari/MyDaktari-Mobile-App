import 'package:flutter/material.dart';

import '../../../../constants/constants.dart';

Future<dynamic> selectTimeDialog(
    {required BuildContext context, required String initialValue, onPressed}) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      String selectedTime = initialValue;
      return AlertDialog(
        title: const Text('Select Time'),
        content: DropdownButtonFormField<String>(
          value: selectedTime,
          onChanged: (value) {
            selectedTime = value!;
            Navigator.of(context).pop();
            onPressed(selectedTime);
          },
          items: timeIntervals.map((time) {
            return DropdownMenuItem<String>(value: time, child: Text(time));
          }).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel', style: TextStyle(color: primaryColor)),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onPressed(selectedTime);
              },
              child: const Text('OK', style: TextStyle(color: primaryColor))),
        ],
      );
    },
  );
}
