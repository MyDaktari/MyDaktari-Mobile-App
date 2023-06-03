// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/presentations/doctor_side/schedule/widgets/working_hours.dart';

import 'clickable_times.dart';

class ScheduleTimes extends StatefulWidget {
  const ScheduleTimes({Key? key}) : super(key: key);

  @override
  _ScheduleTimesState createState() => _ScheduleTimesState();
}

class _ScheduleTimesState extends State<ScheduleTimes> {
  String selectedTime = '30 min';

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Appointment Duration",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        Container(
          color: primaryColor.withOpacity(0.05),
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ClickableTime(
                text: '15 min',
                isSelected: selectedTime == '15 min',
                onPressed: () {
                  setState(() {
                    selectedTime = '15 min';
                  });
                },
              ),
              ClickableTime(
                text: '30 min',
                isSelected: selectedTime == '30 min',
                onPressed: () {
                  setState(() {
                    selectedTime = '30 min';
                  });
                },
              ),
              ClickableTime(
                text: '60 min',
                isSelected: selectedTime == '60 min',
                onPressed: () {
                  setState(() {
                    selectedTime = '60 min';
                  });
                },
              ),
              ClickableTime(
                text: '2 hrs',
                isSelected: selectedTime == '2 hrs',
                onPressed: () {
                  setState(() {
                    selectedTime = '2 hrs';
                  });
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "Working Hours",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        const ScheduleRow()
      ],
    );
  }
}
