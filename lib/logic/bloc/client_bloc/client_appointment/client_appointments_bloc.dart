import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_daktari/repositories/client/client_repository.dart';

import '../../../../models/client_appointment.dart';

part 'client_appointments_event.dart';
part 'client_appointments_state.dart';

class ClientAppointmentsBloc
    extends Bloc<ClientAppointmentsEvent, ClientAppointmentsState> {
  final ClientRepository repo;
  ClientAppointmentsBloc({required ClientRepository repository})
      : repo = repository,
        super(ClientAppointmentsInitial()) {
    on<LoadClientAppointments>(_onLoadClientAppointments);
  }
  void _onLoadClientAppointments(LoadClientAppointments event,
      Emitter<ClientAppointmentsState> emit) async {
    emit(ClientAppointmentsLoading());
    try {
      List<ClientAppointment> ClientAppointments =
          await repo.fetchClientAppointments(clientID: event.cleintId);
      emit(ClientAppointmentsLoaded(clientAppointments: ClientAppointments));
    } catch (error) {
      String errorMessage = error.toString().split(':').last;
      emit(ClientAppointmentsLoadError(message: errorMessage));
    }
  }
}
