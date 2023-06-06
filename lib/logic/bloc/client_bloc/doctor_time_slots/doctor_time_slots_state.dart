part of 'doctor_time_slots_bloc.dart';

abstract class DoctorTimeSlotsState extends Equatable {
  const DoctorTimeSlotsState();

  @override
  List<Object> get props => [];
}

class DoctorTimeSlotsInitial extends DoctorTimeSlotsState {}

class DoctorTimeSlotsLoading extends DoctorTimeSlotsState {}

class DoctorTimeSlotsLoaded extends DoctorTimeSlotsState {
  final List<String> timeAvailable;
  const DoctorTimeSlotsLoaded({required this.timeAvailable});
  @override
  List<Object> get props => [timeAvailable];
}

class DoctorTimeSlotsLoadError extends DoctorTimeSlotsState {
  final String message;
  const DoctorTimeSlotsLoadError({required this.message});
  @override
  List<Object> get props => [message];
}
