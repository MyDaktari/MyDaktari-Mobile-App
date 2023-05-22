part of 'doctor_appointments_bloc.dart';

abstract class DoctorAppointmentsEvent extends Equatable {
  const DoctorAppointmentsEvent();

  @override
  List<Object> get props => [];
}

class LoadDoctorAppointments extends DoctorAppointmentsEvent {
  final String doctorId;

  LoadDoctorAppointments({required this.doctorId});
  @override
  List<Object> get props => [doctorId];
}
