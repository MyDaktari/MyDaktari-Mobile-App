import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_daktari/models/ambulance.dart';
import 'package:my_daktari/repositories/ambulance/ambulance_repository.dart';

part 'ambulance_event.dart';
part 'ambulance_state.dart';

class AmbulanceBloc extends Bloc<AmbulanceEvent, AmbulanceState> {
  AmbulanceRepository _ambulanceRepository;
  AmbulanceBloc({required AmbulanceRepository ambulanceRepository})
      : _ambulanceRepository = ambulanceRepository,
        super(AmbulanceLoading()) {
    on<LoadAmbulances>(_onLoadAmbulances);
  }
  void _onLoadAmbulances(
      LoadAmbulances event, Emitter<AmbulanceState> emit) async {
    emit(AmbulanceLoading());
    try {
      List<AmbulanceModel> ambulance =
          await _ambulanceRepository.getAmbulances();
      emit(AmbulanceLoaded(ambulances: ambulance));
    } catch (error) {
      String errorMessage = error.toString().split(':').last;
      emit(AmbulanceLoadingError(message: errorMessage));
    }
  }
}
