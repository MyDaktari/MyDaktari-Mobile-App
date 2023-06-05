import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/presentations/doctor_side/schedule/models/dayschedule.dart';
import 'package:my_daktari/presentations/doctor_side/schedule/widgets/schedule_item.dart';

import '../../../../constants/constants.dart';
import '../../../../logic/cubit/doctor_schedules/doctor_schedule.dart';

class ScheduleRow extends StatefulWidget {
  const ScheduleRow({Key? key}) : super(key: key);

  @override
  _ScheduleRowState createState() => _ScheduleRowState();
}

class _ScheduleRowState extends State<ScheduleRow> {
  late final ScheduleCubit scheduleCubit;

  @override
  void dispose() {
    scheduleCubit.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Initialize the schedules with default values
    final initialSchedules = daysOfWeek.map((day) {
      return DaySchedule(
        day: day,
        isEnabled: true,
        startTime: timeIntervals.first,
        endTime: timeIntervals.first,
      );
    }).toList();
    scheduleCubit = ScheduleCubit(initialSchedules);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScheduleCubit>.value(
      value: scheduleCubit,
      child: Column(
        children: [
          BlocBuilder<ScheduleCubit, List<DaySchedule>>(
            builder: (context, schedules) {
              print(schedules.first.startTime);
              return Column(
                children: [
                  for (final schedule in schedules)
                    ScheduleItemWidget(
                      schedule: schedule,
                      timeIntervals: timeIntervals,
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
