part of 'blood_sugar_bloc.dart';

abstract class BloodSugarState extends Equatable {
  const BloodSugarState();

  @override
  List<Object> get props => [];
}

class BloodSugarInitial extends BloodSugarState {}

class BloodSugarLoading extends BloodSugarState {}

class BloodSugarLoadSuccess extends BloodSugarState {
  final List<BloodSugarModel> records;
  final double average;
  final double highest;
  final double lowest;
  const BloodSugarLoadSuccess(
      {required this.records,
      required this.average,
      required this.highest,
      required this.lowest});
  @override
  List<Object> get props => [records, average, highest, lowest];
}

class BloodSugarsLoadinFailed extends BloodSugarState {
  final String message;
  const BloodSugarsLoadinFailed({required this.message});
  @override
  List<Object> get props => [message];
}
