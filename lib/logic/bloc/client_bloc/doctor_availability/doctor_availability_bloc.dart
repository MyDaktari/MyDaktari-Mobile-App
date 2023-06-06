import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_daktari/repositories/client/client_repository.dart';

part 'doctor_availability_event.dart';
part 'doctor_availability_state.dart';

class DoctorAvailabilityBloc
    extends Bloc<DoctorAvailabilityEvent, DoctorAvailabilityState> {
  ClientRepository repo;
  DoctorAvailabilityBloc({required ClientRepository repository})
      : repo = repository,
        super(DoctorAvailabilityInitial()) {
    on<LoadDoctorAvailability>(_onLoadDoctorAvailability);
  }
  void _onLoadDoctorAvailability(LoadDoctorAvailability event,
      Emitter<DoctorAvailabilityState> emit) async {
    try {
      emit(DoctorAvailabilityLoading());
      List<String> timeAvailable = await repo.fetchDoctorAvailability(
          doctorId: event.doctorId, date: event.date);
      emit(DoctorAvailabilityLoaded(timeAvailable: timeAvailable));
    } catch (error) {
      String errorMessage = error.toString().split(':').last;
      emit(DoctorAvailabilityLoadError(message: errorMessage));
    }
  }
}
