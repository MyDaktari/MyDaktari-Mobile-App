class DaySchedule {
  final String day;
  bool isEnabled;
  String startTime;
  String endTime;

  DaySchedule({
    required this.day,
    required this.isEnabled,
    required this.startTime,
    required this.endTime,
  });

  DaySchedule copyWith({
    String? day,
    bool? isEnabled,
    String? startTime,
    String? endTime,
  }) {
    return DaySchedule(
      day: day ?? this.day,
      isEnabled: isEnabled ?? this.isEnabled,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }
}
