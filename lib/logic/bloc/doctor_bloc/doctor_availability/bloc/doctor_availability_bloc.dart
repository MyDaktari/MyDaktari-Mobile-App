import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../../../repositories/doctor/doctor_repository.dart';

part 'doctor_availability_event.dart';
part 'doctor_availability_state.dart';

class DoctorAvailabilityBloc
    extends Bloc<DoctorAvailabilityEvent, DoctorAvailabilityState> {
  final DoctorRepository doctorRepository;
  DoctorAvailabilityBloc({required DoctorRepository doctorRepository})
      : doctorRepository = doctorRepository,
        super(DoctorAvailabilityLoading()) {
    on<AddDoctorAvailability>(_onAddDoctorAvailability);
    on<LoadDoctorAvailability>(_onLoadDoctorAvailability);
  }

  void _onLoadDoctorAvailability(LoadDoctorAvailability event,
      Emitter<DoctorAvailabilityState> emit) async {
    emit(DoctorAvailabilityLoading());
    try {
      emit(DoctorAvailabilityLoaded());
    } catch (error) {
      String errorMessage = error.toString().split(':').last;
      emit(DoctorAvailabilityLoadingError(message: errorMessage));
    }
  }

  void _onAddDoctorAvailability(AddDoctorAvailability event,
      Emitter<DoctorAvailabilityState> emit) async {
    emit(DoctorAvailabilityLoading());
    try {
      print("Hellooooooooo");
      final result = await doctorRepository.addDoctorAvailability(
          doctorId: event.doctorId,
          duration: event.duration,
          data: event.availability);
      Fluttertoast.showToast(msg: result);
      emit(DoctorAvailabilityLoaded());
    } catch (error) {
      String errorMessage = error.toString().split(':').last;
      Fluttertoast.showToast(msg: errorMessage);

      emit(DoctorAvailabilityLoadingError(message: errorMessage));
    }
  }
}
