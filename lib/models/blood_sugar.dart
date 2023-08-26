import '../constants/enums.dart';

class BloodSugarReading {
  final DateTime dateTime;
  final double glucoseLevel;
  final String note;

  BloodSugarReading({
    required this.dateTime,
    required this.glucoseLevel,
    required this.note,
    required MealType mealType,
  });
}
