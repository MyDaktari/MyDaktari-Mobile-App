import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/presentations/doctor_side/schedule/widgets/time_dropdown.dart';

import '../../../../constants/constants.dart';


import '../../../../logic/cubit/doctor_schedules/doctor_schedule.dart';
import '../models/dayschedule.dart';

class ScheduleItemWidget extends StatelessWidget {
  final DaySchedule schedule;
  final List<String> timeIntervals;

  const ScheduleItemWidget({
    required this.schedule,
    required this.timeIntervals,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduleCubit, List<DaySchedule>>(
      builder: (context, schedules) {
        void updateScheduleState(DaySchedule updatedSchedule) {
          BlocProvider.of<ScheduleCubit>(context)
              .updateSchedule(updatedSchedule);
        }

        return Row(
          children: [
            SizedBox(
              width: 100,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Switch(
                    value: schedule.isEnabled,
                    onChanged: (value) {
                      final updatedSchedule =
                          schedule.copyWith(isEnabled: value);
                      updateScheduleState(updatedSchedule);
                    },
                    activeColor: primaryColor,
                  ),
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
                onPressed: (selectedTime) {
                  final updatedSchedule =
                      schedule.copyWith(startTime: selectedTime);
                  updateScheduleState(updatedSchedule);
                },
              ),
            ),
            Visibility(visible: schedule.isEnabled, child: const Text('--')),
            Visibility(
              visible: schedule.isEnabled,
              child: TimeDropDown(
                initialValue: schedule.endTime,
                timeIntervals: timeIntervals,
                onPressed: (selectedTime) {
                  final updatedSchedule =
                      schedule.copyWith(endTime: selectedTime);
                  updateScheduleState(updatedSchedule);
                },
              ),
            ),
            Visibility(
              visible: schedule.isEnabled,
              child: Expanded(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: InkWell(
                    onTap: () {
                      // Add button pressed
                      // scheduleCubit.addSchedule(schedule);
                    },
                    child: const Icon(Icons.add),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
