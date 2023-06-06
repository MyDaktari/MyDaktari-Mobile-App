part of 'doctor_availability_bloc.dart';

abstract class DoctorAvailabilityEvent extends Equatable {
  const DoctorAvailabilityEvent();

  @override
  List<Object> get props => [];
}

class LoadDoctorAvailability extends DoctorAvailabilityEvent {
  final String doctorId;
  final DateTime date;
  const LoadDoctorAvailability({required this.doctorId, required this.date});
  @override
  List<Object> get props => [doctorId, date];
}
