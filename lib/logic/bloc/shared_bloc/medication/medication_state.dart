part of 'medication_bloc.dart';

abstract class MedicationState extends Equatable {
  const MedicationState();

  @override
  List<Object> get props => [];
}

class MedicationInitial extends MedicationState {}

class MedicationLoading extends MedicationState {}

class MedicationLoadSuccess extends MedicationState {
  final List<MedicationModel> records;

  const MedicationLoadSuccess({required this.records});
  @override
  List<Object> get props => [records];
}

class MedicationsLoadinFailed extends MedicationState {
  final String message;
  const MedicationsLoadinFailed({required this.message});
  @override
  List<Object> get props => [message];
}
