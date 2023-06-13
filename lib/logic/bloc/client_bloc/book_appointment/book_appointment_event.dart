part of 'book_appointment_bloc.dart';

abstract class BookAppointmentEvent extends Equatable {
  const BookAppointmentEvent();

  @override
  List<Object> get props => [];
}

class BookNewAppointment extends BookAppointmentEvent {
  final DateTime date;
  final String time;
  final String userId;
  final String doctorId;
  final String symptomID;
  final String description;
  final String meetingOption;

  BookNewAppointment(
      {required this.date,
      required this.time,
      required this.userId,
      required this.doctorId,
      required this.symptomID,
      required this.description,
      required this.meetingOption});
  @override
  List<Object> get props =>
      [date, time, userId, doctorId, symptomID, description, meetingOption];
}
