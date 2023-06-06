part of 'doctor_availability_bloc.dart';

abstract class DoctorAvailabilityState extends Equatable {
  const DoctorAvailabilityState();

  @override
  List<Object> get props => [];
}

class DoctorAvailabilityInitial extends DoctorAvailabilityState {}

class DoctorAvailabilityLoading extends DoctorAvailabilityState {}

class DoctorAvailabilityLoaded extends DoctorAvailabilityState {
  final List<String> timeAvailable;
  const DoctorAvailabilityLoaded({required this.timeAvailable});
  @override
  List<Object> get props => [timeAvailable];
}

class DoctorAvailabilityLoadError extends DoctorAvailabilityState {
  final String message;
  const DoctorAvailabilityLoadError({required this.message});
  @override
  List<Object> get props => [message];
}
