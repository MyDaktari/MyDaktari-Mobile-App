part of 'doctor_patients_bloc.dart';

abstract class DoctorPatientsState extends Equatable {
  const DoctorPatientsState();

  @override
  List<Object> get props => [];
}

class DoctorPatientsLoading extends DoctorPatientsState {}

class DoctorPatientsLoaded extends DoctorPatientsState {
  final List<PatientModel> patients;
  const DoctorPatientsLoaded({this.patients = const <PatientModel>[]});

  @override
  List<Object> get props => [patients];
}

class DoctorPatientsLoadingError extends DoctorPatientsState {
  final String message;
  DoctorPatientsLoadingError({required this.message});

  @override
  List<Object> get props => [message];
}
