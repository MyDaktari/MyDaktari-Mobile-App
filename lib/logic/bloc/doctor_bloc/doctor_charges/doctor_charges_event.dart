part of 'doctor_charges_bloc.dart';

abstract class DoctorChargesEvent extends Equatable {
  const DoctorChargesEvent();

  @override
  List<Object> get props => [];
}

class LoadDoctorCharges extends DoctorChargesEvent {
  final String doctorId;
  const LoadDoctorCharges({required this.doctorId});
  @override
  List<Object> get props => [doctorId];
}

class SetDoctorCharges extends DoctorChargesEvent {
  final String doctorId, phoneCallCost, videoCallCost, chatCost;
  const SetDoctorCharges(
      {required this.doctorId,
      required this.chatCost,
      required this.phoneCallCost,
      required this.videoCallCost});
  @override
  List<Object> get props => [doctorId, chatCost, phoneCallCost, videoCallCost];
}
