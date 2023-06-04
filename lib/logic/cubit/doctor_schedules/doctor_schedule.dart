import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../presentations/doctor_side/schedule/models/dayschedule.dart';

class ScheduleCubit extends Cubit<List<DaySchedule>> {
  ScheduleCubit(List<DaySchedule> initialSchedules) : super(initialSchedules);

  void addSchedule(DaySchedule schedule) {
    state.add(schedule);
    emit(List.from(state));
  }

  void removeSchedule(DaySchedule schedule) {
    state.remove(schedule);
    emit(List.from(state));
  }

  void updateSchedule(DaySchedule schedule) {
    final index = state.indexWhere((s) => s.day == schedule.day);
    if (index != -1) {
      final updatedSchedule = state[index].copyWith(
        startTime: schedule.startTime,
        endTime: schedule.endTime,
      );
      state[index] = updatedSchedule;
      emit(List.from(state));
    }
  }
}
