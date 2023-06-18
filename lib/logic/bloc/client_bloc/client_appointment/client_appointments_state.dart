part of 'client_appointments_bloc.dart';

abstract class ClientAppointmentsState extends Equatable {
  const ClientAppointmentsState();

  @override
  List<Object> get props => [];
}

class ClientAppointmentsInitial extends ClientAppointmentsState {}

class ClientAppointmentsLoading extends ClientAppointmentsState {}

class ClientAppointmentsLoaded extends ClientAppointmentsState {
  final List<ClientAppointment> clientAppointments;
  const ClientAppointmentsLoaded({required this.clientAppointments});
  @override
  List<Object> get props => [clientAppointments];
}

class ClientAppointmentsLoadError extends ClientAppointmentsState {
  final String message;
  const ClientAppointmentsLoadError({required this.message});

  @override
  List<Object> get props => [message];
}
