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
