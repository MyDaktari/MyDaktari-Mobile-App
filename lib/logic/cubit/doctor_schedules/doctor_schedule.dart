import 'dart:convert';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/constants.dart';
import '../../../presentations/doctor_side/schedule/models/dayschedule.dart';

class ScheduleCubit extends Cubit<List<DaySchedule>> {
  ScheduleCubit(List<DaySchedule> initialSchedules) : super(initialSchedules);

  void saveScheduleToMemory(List<DaySchedule> schedule) async {
    final convertedString = schedulesToAvailability(schedule);
    SharedPreferences prefs = await SharedPreferences.getInstance();

    prefs.setString("schedules", jsonEncode(convertedString));
    print("saving and getting from memorrrrrrrrrrrrrrrrry");
    print(prefs.getString("schedules"));
  }

  void addSchedule(DaySchedule schedule) {
    state.add(schedule.copyWith(id: UniqueKey().toString()));
    schedulesConstant = List.from(state);
    saveScheduleToMemory(schedulesConstant);
    emit(schedulesConstant);
  }

  void removeSchedule(DaySchedule schedule) {
    if (state.any((s) => s.day == schedule.day && s.id != schedule.id)) {
      state.removeWhere((s) => s.id == schedule.id);
      schedulesConstant = List.from(state);
      saveScheduleToMemory(schedulesConstant);
      emit(schedulesConstant);
    } else {
      Fluttertoast.showToast(msg: 'Disable day instead');
    }
  }

  void updateSchedule(DaySchedule schedule) {
    final index = state.indexWhere((s) => s.id == schedule.id);
    if (index != -1) {
      final timeFormat = DateFormat('HH:mm');
      final startTime = timeFormat.parse(schedule.startTime);
      final endTime = timeFormat.parse(schedule.endTime);

      // Check if the start time is earlier than the end time

      final changingEnabled = state[index].isEnabled == schedule.isEnabled;
      if (startTime.isAfter(endTime) && changingEnabled) {
        Fluttertoast.showToast(msg: 'End time needs to be after start time');
        return;
      } // Check if the start time is equal to the end time
      if (startTime == endTime && changingEnabled) {
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
      schedulesConstant = List.from(state);
      saveScheduleToMemory(schedulesConstant);
      emit(schedulesConstant);
    }
  }
}
