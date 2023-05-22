part of 'doctor_patients_bloc.dart';

abstract class DoctorPatientsEvent extends Equatable {
  const DoctorPatientsEvent();

  @override
  List<Object> get props => [];
}

class LoadDoctorPatients extends DoctorPatientsEvent {
  final String doctorId;

  LoadDoctorPatients({required this.doctorId});

  @override
  List<Object> get props => [doctorId];
}
