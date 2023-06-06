part of 'client_appointments_bloc.dart';

abstract class ClientAppointmentsEvent extends Equatable {
  const ClientAppointmentsEvent();

  @override
  List<Object> get props => [];
}

class BookAppointment extends ClientAppointmentsEvent {
  final String userID,
      doctorID,
      startTime,
      endTime,
      symptomID,
      description,
      date,
      meetingOption;
  const BookAppointment(
      {required this.userID,
      required this.doctorID,
      required this.startTime,
      required this.endTime,
      required this.symptomID,
      required this.description,
      required this.date,
      required this.meetingOption});

  @override
  List<Object> get props => [
        userID,
        doctorID,
        startTime,
        endTime,
        symptomID,
        description,
        date,
        meetingOption
      ];
}

class LoadClientAppointments extends ClientAppointmentsEvent {
  final String userId;
  const LoadClientAppointments({required this.userId});
  @override
  List<Object> get props => [userId];
}
