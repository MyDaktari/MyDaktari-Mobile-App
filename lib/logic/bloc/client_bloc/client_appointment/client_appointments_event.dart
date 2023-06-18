part of 'client_appointments_bloc.dart';

abstract class ClientAppointmentsEvent extends Equatable {
  const ClientAppointmentsEvent();

  @override
  List<Object> get props => [];
}

class LoadClientAppointments extends ClientAppointmentsEvent {
  final String cleintId;
  const LoadClientAppointments({required this.cleintId});
  @override
  List<Object> get props => [cleintId];
}
