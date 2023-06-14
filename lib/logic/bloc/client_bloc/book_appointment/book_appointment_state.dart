part of 'book_appointment_bloc.dart';

abstract class BookAppointmentState extends Equatable {
  const BookAppointmentState();

  @override
  List<Object> get props => [];
}

class BookAppointmentInitial extends BookAppointmentState {}

class BookAppointmentLoading extends BookAppointmentState {}

class BookAppointmentLoaded extends BookAppointmentState {
  final String amount, appointmentID;
  const BookAppointmentLoaded(
      {required this.amount, required this.appointmentID});
  @override
  List<Object> get props => [amount, appointmentID];
}

class BookAppointmentLoadError extends BookAppointmentState {
  final String message;
  const BookAppointmentLoadError({required this.message});
  @override
  List<Object> get props => [message];
}
