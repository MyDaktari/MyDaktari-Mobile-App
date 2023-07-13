import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/presentations/doctor_side/schedule/models/dayschedule.dart';
import 'package:my_daktari/presentations/doctor_side/schedule/widgets/schedule_item.dart';

import '../../../../constants/constants.dart';
import '../../../../logic/cubit/doctor_schedules/doctor_schedule.dart';

class ScheduleRow extends StatefulWidget {
  ScheduleRow({Key? key}) : super(key: key);

  @override
  State<ScheduleRow> createState() => _ScheduleRowState();
}

class _ScheduleRowState extends State<ScheduleRow> {
  final ScheduleCubit scheduleCubit = ScheduleCubit(schedulesConstant);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScheduleCubit>.value(
      value: scheduleCubit,
      child: Column(
        children: [
          BlocBuilder<ScheduleCubit, List<DaySchedule>>(
            builder: (context, schedules) {
              final Map<String, int> dayPriority = {
                'Mon': 1,
                'Tue': 2,
                'Wed': 3,
                'Thur': 4,
                'Fri': 5,
                'Sat': 6,
                'Sun': 7,
              };

              schedules.sort((a, b) {
                // Compare the days using the priority map table
                int dayComparison =
                    dayPriority[a.day]!.compareTo(dayPriority[b.day]!);
                if (dayComparison != 0) {
                  return dayComparison;
                }

                // If the days are equal, compare the start times
                int startTimeComparison = a.startTime.compareTo(b.startTime);
                if (startTimeComparison != 0) {
                  return startTimeComparison;
                }

                // If the start times are also equal, compare the end times
                return a.endTime.compareTo(b.endTime);
              });

              return Column(
                children: [
                  for (int i = 0; i < schedules.length; i++)
                    ScheduleItemWidget(
                      schedule: schedules[i],
                    
                      timeIntervals: timeIntervals,
                      isDuplicate:
                          i > 0 && schedules[i].day == schedules[i - 1].day,
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
