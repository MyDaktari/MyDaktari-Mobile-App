import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
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
            //chan
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
            child:
                Text('Cancel', style: TextStyle(color: AppColor.primaryColor)),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                onPressed(selectedTime);
              },
              child:
                  Text('OK', style: TextStyle(color: AppColor.primaryColor))),
        ],
      );
    },
  );
}
