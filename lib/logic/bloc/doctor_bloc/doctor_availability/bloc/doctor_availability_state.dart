part of 'doctor_availability_bloc.dart';

abstract class DoctorAvailabilityState extends Equatable {
  const DoctorAvailabilityState();

  @override
  List<Object> get props => [];
}

class DoctorAvailabilityInitial extends DoctorAvailabilityState {}

class DoctorAvailabilityLoading extends DoctorAvailabilityState {}

class DoctorAvailabilityLoadingError extends DoctorAvailabilityState {
  final String message;
  const DoctorAvailabilityLoadingError({required this.message});

  @override
  List<Object> get props => [message];
}

class DoctorAvailabilityLoaded extends DoctorAvailabilityState {}
