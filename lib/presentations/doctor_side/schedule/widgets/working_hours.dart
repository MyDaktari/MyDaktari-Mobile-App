import 'package:flutter/material.dart';
import 'package:my_daktari/presentations/doctor_side/schedule/widgets/schedule_item.dart';

import '../../../../constants/constants.dart';
import '../models/dayschedule.dart';

class ScheduleRow extends StatefulWidget {
  const ScheduleRow({Key? key}) : super(key: key);

  @override
  _ScheduleRowState createState() => _ScheduleRowState();
}

class _ScheduleRowState extends State<ScheduleRow> {
  List<DaySchedule> schedules = [];

  @override
  void initState() {
    super.initState();
    // Initialize the schedules with default values
    schedules = daysOfWeek.map((day) {
      return DaySchedule(
        day: day,
        isEnabled: true,
        startTime: timeIntervals.first,
        endTime: timeIntervals.first,
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final schedule in schedules)
          ScheduleItemWidget(
            schedule: schedule,
            timeIntervals: timeIntervals,
            onSwitchChanged: (value) {
              setState(() {
                schedule.isEnabled = value;
              });
            },
            onStartTimeSelected: (selectedTime) {
              setState(() {
                schedule.startTime = selectedTime;
              });
            },
            onEndTimeSelected: (selectedTime) {
              setState(() {
                schedule.endTime = selectedTime;
              });
            },
            onAddPressed: () {
              // Add button pressed
              print('Add button pressed for day: ${schedule.day}');
            },
          ),
      ],
    );
  }
}
