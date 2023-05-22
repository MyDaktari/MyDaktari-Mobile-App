part of 'doctor_appointments_bloc.dart';

abstract class DoctorAppointmentsState extends Equatable {
  const DoctorAppointmentsState();

  @override
  List<Object> get props => [];
}

class DoctorAppointmentsLoading extends DoctorAppointmentsState {}

class DoctorAppointmentsLoaded extends DoctorAppointmentsState {
  final List<AppointmentModel> appointments;
  const DoctorAppointmentsLoaded(
      {this.appointments = const <AppointmentModel>[]});

  @override
  List<Object> get props => [appointments];
}

class DoctorAppointmentsLoadingError extends DoctorAppointmentsState {
  final String message;
  DoctorAppointmentsLoadingError({required this.message});

  @override
  List<Object> get props => [message];
}
