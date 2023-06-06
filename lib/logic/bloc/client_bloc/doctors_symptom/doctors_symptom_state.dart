part of 'doctors_symptom_bloc.dart';

abstract class DoctorsBySymptomsState extends Equatable {
  const DoctorsBySymptomsState();

  @override
  List<Object> get props => [];
}

class DoctorsBySymptomsInitialized extends DoctorsBySymptomsState {}

class DoctorsBySymptomsLoading extends DoctorsBySymptomsState {}

class DoctorsBySymptomsLoaded extends DoctorsBySymptomsState {
  final List<DoctorProfileModel> doctors;

  const DoctorsBySymptomsLoaded({required this.doctors});
  @override
  List<Object> get props => [doctors];
}

class DoctorsBySymptomsLoadError extends DoctorsBySymptomsState {
  final String errorMessage;

  DoctorsBySymptomsLoadError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
