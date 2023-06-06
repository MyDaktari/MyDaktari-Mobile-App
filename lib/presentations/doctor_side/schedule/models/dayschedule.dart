

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
    required this.id
  });

  DaySchedule copyWith({
    String? day,
    bool? isEnabled,
    String? startTime,
    String? endTime,
    String? id
  }) {
    return DaySchedule(
      id: id ?? this.id,
      day: day ?? this.day,
      isEnabled: isEnabled ?? this.isEnabled,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}
