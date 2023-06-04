part of 'doctor_charges_bloc.dart';

abstract class DoctorChargesState extends Equatable {
  const DoctorChargesState();

  @override
  List<Object> get props => [];
}

class DoctorChargesInitial extends DoctorChargesState {}

class DoctorChargesLoading extends DoctorChargesState {}

class DoctorChargesLoaded extends DoctorChargesState {
  final DoctorChargesModel charges;
  const DoctorChargesLoaded({required this.charges});

  @override
  List<Object> get props => [charges];
}

class DoctorChargesLoadError extends DoctorChargesState {
  final String message;
  const DoctorChargesLoadError({required this.message});
  @override
  List<Object> get props => [message];
}
