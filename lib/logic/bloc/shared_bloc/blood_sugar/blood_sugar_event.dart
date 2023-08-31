part of 'blood_sugar_bloc.dart';

abstract class BloodSugarEvent extends Equatable {
  const BloodSugarEvent();

  @override
  List<Object> get props => [];
}

class LoadBloodSugarRecord extends BloodSugarEvent {
  final String userId;
  const LoadBloodSugarRecord({required this.userId});
  @override
  List<Object> get props => [userId];
}

class AddBloodSugarRecord extends BloodSugarEvent {
  final String userId, timeBase, date, time;
  final double glucoseLevel;
  const AddBloodSugarRecord(
      {required this.userId,
      required this.timeBase,
      required this.date,
      required this.time,
      required this.glucoseLevel});
  @override
  List<Object> get props => [userId, timeBase, date, time, glucoseLevel];
}
