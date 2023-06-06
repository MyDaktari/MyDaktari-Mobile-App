part of 'doctor_time_slots_bloc.dart';

abstract class DoctorTimeSlotsEvent extends Equatable {
  const DoctorTimeSlotsEvent();

  @override
  List<Object> get props => [];
}

class LoadDoctorTimeSlots extends DoctorTimeSlotsEvent {
  final String doctorId;
  final DateTime date;
  const LoadDoctorTimeSlots({required this.doctorId, required this.date});
  @override
  List<Object> get props => [doctorId, date];
}
