import 'dart:convert';

import '../../../../constants/constants.dart';

class DaySchedule {
  String id;
  final String day;
  bool isEnabled;
  String startTime;
  String endTime;

  DaySchedule({
    required this.day,
    required this.isEnabled,
    required this.startTime,
    required this.endTime,
    required this.id,
  });

  DaySchedule copyWith({
    String? day,
    bool? isEnabled,
    String? startTime,
    String? endTime,
    String? id,
  }) {
    return DaySchedule(
      id: id ?? this.id,
      day: day ?? this.day,
      isEnabled: isEnabled ?? this.isEnabled,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'day': day,
      'isEnabled': isEnabled,
      'startTime': startTime,
      'endTime': endTime,
    };
  }

  factory DaySchedule.fromJson(Map<String, dynamic> json) {
    return DaySchedule(
      id: json['id'],
      day: json['day'],
      isEnabled: json['isEnabled'],
      startTime: json['startTime'],
      endTime: json['endTime'],
    );
  }
}

Map<String, List<Map<String, String>>> schedulesToAvailability(
    List<DaySchedule> schedules) {
  final availability = <String, List<Map<String, String>>>{};

  for (final schedule in schedules) {
    final dayAbbreviated = schedule.day;
    final dayFullName = dayFullNameMap[dayAbbreviated];
    final start = convertTo24HourFormat(schedule.startTime);
    final end = convertTo24HourFormat(schedule.endTime);
    final isEnabled = schedule.isEnabled;

    if (isEnabled) {
      availability[dayFullName!] ??= [];
      availability[dayFullName]!.add({'startTime': start, 'endTime': end});
    } else {
      availability[dayFullName!] ??= [];
    }
  }

  return availability;
}

String removeSeconds(String time) {
  final timeComponents = time.split(':');
  return timeComponents.length == 3
      ? timeComponents.sublist(0, 2).join(':')
      : time;
}

List<DaySchedule> availabilityToSchedules(Map<String, dynamic> availability) {
  final schedules = <DaySchedule>[];

  for (final entry in availability.entries) {
    final dayFullName = entry.key;
    final dayAbbreviated = dayFullNameMap.entries
        .firstWhere(
          (entry) => entry.value == dayFullName,
          orElse: () => MapEntry('', ''),
        )
        .key;
    final timeSlots = entry.value;

    if (timeSlots != null && timeSlots is List) {
      for (final timeSlot in timeSlots) {
        final start =
            convertTo12HourFormat(removeSeconds(timeSlot['startTime']));
        final end = convertTo12HourFormat(removeSeconds(timeSlot['endTime']));

        final schedule = DaySchedule(
          day: dayAbbreviated,
          isEnabled: true,
          startTime: start,
          endTime: end,
          id: '${dayAbbreviated}-${timeIntervals.first}-${timeIntervals.first}', // Set the appropriate ID here
        );
        schedules.add(schedule);
      }
    }
  }

  // Add empty DaySchedule objects for days not found in availability
  for (final entry in dayFullNameMap.entries) {
    final dayFullName = entry.value;
    final dayAbbreviated = entry.key;

    if (!availability.containsKey(dayFullName)) {
      final schedule = DaySchedule(
        day: dayAbbreviated,
        isEnabled: false,
        startTime: timeIntervals.first,
        endTime: timeIntervals.last,
        id: '${dayAbbreviated}-${timeIntervals.first}-${timeIntervals.last}', // Set the appropriate ID here
      );
      schedules.add(schedule);
    }
  }

  return schedules;
}
