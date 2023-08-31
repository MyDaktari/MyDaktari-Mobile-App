part of 'medication_bloc.dart';

abstract class MedicationEvent extends Equatable {
  const MedicationEvent();

  @override
  List<Object> get props => [];
}

class LoadMedicationRecord extends MedicationEvent {
  final String userId;
  const LoadMedicationRecord({required this.userId});
  @override
  List<Object> get props => [userId];
}

class AddMedicationRecord extends MedicationEvent {
  final String userId, timeBase, date, time;
  final double glucoseLevel;
  const AddMedicationRecord(
      {required this.userId,
      required this.timeBase,
      required this.date,
      required this.time,
      required this.glucoseLevel});
  @override
  List<Object> get props => [userId, timeBase, date, time, glucoseLevel];
}
