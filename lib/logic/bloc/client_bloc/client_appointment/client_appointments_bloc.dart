import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'client_appointments_event.dart';
part 'client_appointments_state.dart';

class ClientAppointmentsBloc extends Bloc<ClientAppointmentsEvent, ClientAppointmentsState> {
  ClientAppointmentsBloc() : super(ClientAppointmentsInitial()) {
    on<ClientAppointmentsEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
