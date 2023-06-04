part of 'doctor_availability_bloc.dart';

abstract class DoctorAvailabilityEvent extends Equatable {
  const DoctorAvailabilityEvent();

  @override
  List<Object> get props => [];
}

class LoadDoctorAvailability extends DoctorAvailabilityEvent {
  final String doctorId;

  LoadDoctorAvailability({required this.doctorId});
  @override
  List<Object> get props => [doctorId];
}

class AddDoctorAvailability extends DoctorAvailabilityEvent {
  final int doctorId;
  final int duration; // should be in minutes
  final Map<String, List<Map<String, dynamic>>> availability;

  AddDoctorAvailability({
    required this.doctorId,
    required this.duration,
    required this.availability,
  });

  @override
  List<Object> get props => [doctorId, duration, availability];
}
