import 'package:flutter/material.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/presentations/doctor_side/schedule/widgets/time_dropdown.dart';

import '../models/dayschedule.dart';

class ScheduleItemWidget extends StatelessWidget {
  final DaySchedule schedule;
  final List<String> timeIntervals;
  final ValueChanged<bool> onSwitchChanged;
  final ValueChanged<String> onStartTimeSelected;
  final ValueChanged<String> onEndTimeSelected;
  final VoidCallback onAddPressed;

  const ScheduleItemWidget({
    required this.schedule,
    required this.timeIntervals,
    required this.onSwitchChanged,
    required this.onStartTimeSelected,
    required this.onEndTimeSelected,
    required this.onAddPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 100,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Switch(
                  value: schedule.isEnabled,
                  onChanged: onSwitchChanged,
                  activeColor: primaryColor),
              const SizedBox(width: 8),
              Text(schedule.day),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Visibility(
          visible: schedule.isEnabled,
          replacement: const Text('Unavailable'),
          child: TimeDropDown(
            initialValue: schedule.startTime,
            timeIntervals: timeIntervals,
            onPressed: onStartTimeSelected,
          ),
        ),
        Visibility(visible: schedule.isEnabled, child: const Text('--')),
        Visibility(
          visible: schedule.isEnabled,
          child: TimeDropDown(
              initialValue: schedule.endTime,
              timeIntervals: timeIntervals,
              onPressed: onEndTimeSelected),
        ),
        Visibility(
          visible: schedule.isEnabled,
          child: Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: InkWell(onTap: onAddPressed, child: const Icon(Icons.add)),
            ),
          ),
        ),
      ],
    );
  }
}
