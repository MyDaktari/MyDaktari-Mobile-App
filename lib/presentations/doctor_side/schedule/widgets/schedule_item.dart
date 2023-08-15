import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/presentations/doctor_side/schedule/widgets/time_dropdown.dart';

import '../../../../constants/colors.dart';

import '../../../../logic/cubit/doctor_schedules/doctor_schedule.dart';
import '../models/dayschedule.dart';

class ScheduleItemWidget extends StatelessWidget {
  final DaySchedule schedule;
  final List<String> timeIntervals;
  final bool isDuplicate;

  const ScheduleItemWidget(
      {required this.schedule,
      required this.timeIntervals,
      this.isDuplicate = false});

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
                      activeColor: AppColor.primaryColor),
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
                  child: isDuplicate
                      ? InkWell(
                          onTap: () {
                            // Add button pressed
                            BlocProvider.of<ScheduleCubit>(context)
                                .removeSchedule(schedule);
                          },
                          child: const Icon(Icons.remove),
                        )
                      : InkWell(
                          onTap: () {
                            // Add button pressed
                            BlocProvider.of<ScheduleCubit>(context)
                                .addSchedule(schedule);
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
