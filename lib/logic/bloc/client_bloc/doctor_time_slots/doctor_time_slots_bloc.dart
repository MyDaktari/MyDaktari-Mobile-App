import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_daktari/repositories/client/client_repository.dart';

part 'doctor_time_slots_event.dart';
part 'doctor_time_slots_state.dart';

class DoctorTimeSlotsBloc
    extends Bloc<DoctorTimeSlotsEvent, DoctorTimeSlotsState> {
  ClientRepository repo;
  DoctorTimeSlotsBloc({required ClientRepository repository})
      : repo = repository,
        super(DoctorTimeSlotsInitial()) {
    on<LoadDoctorTimeSlots>(_onLoadDoctorTimeSlots);
  }
  void _onLoadDoctorTimeSlots(
      LoadDoctorTimeSlots event, Emitter<DoctorTimeSlotsState> emit) async {
    try {
      emit(DoctorTimeSlotsLoading());
      List<String> timeAvailable = await repo.fetchDoctorAvailability(
          doctorId: event.doctorId, date: event.date);
      emit(DoctorTimeSlotsLoaded(timeAvailable: timeAvailable));
    } catch (error) {
      String errorMessage = error.toString().contains("host lookup")
          ? 'Connect to the internet '
          : error.toString().split("Exception:").last;
      emit(DoctorTimeSlotsLoadError(message: errorMessage));
    }
  }
}
