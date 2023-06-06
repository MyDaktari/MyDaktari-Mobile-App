import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentations/doctor_side/schedule/models/dayschedule.dart';

class ScheduleCubit extends Cubit<List<DaySchedule>> {
  ScheduleCubit(List<DaySchedule> initialSchedules) : super(initialSchedules);

  void addSchedule(DaySchedule schedule) {
    state.add(schedule.copyWith(id: UniqueKey().toString()));
    emit(List.from(state));
  }

  void removeSchedule(DaySchedule schedule) {
    state.removeWhere((s) => s.id == schedule.id);
    emit(List.from(state));
  }

  void updateSchedule(DaySchedule schedule) {
    final index = state.indexWhere((s) => s.id == schedule.id);
    if (index != -1) {
      final timeFormat = DateFormat('h:mm a');
      final startTime = timeFormat.parse(schedule.startTime);
      final endTime = timeFormat.parse(schedule.endTime);

      // Check if the start time is earlier than the end time
      if (startTime.isAfter(endTime)) {
        Fluttertoast.showToast(msg: 'End time needs to be after start time');
        return;
      } // Check if the start time is equal to the end time
      if (startTime == endTime) {
        Fluttertoast.showToast(
            msg: 'Start time cannot be the same as end time');
        return;
      }

      final updatedSchedule = state[index].copyWith(
        startTime: schedule.startTime,
        endTime: schedule.endTime,
        isEnabled: schedule.isEnabled,
      );
      state[index] = updatedSchedule;
      emit(List.from(state));
    }
  }
}
