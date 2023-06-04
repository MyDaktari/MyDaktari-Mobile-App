import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/charge.dart';
import '../../../../repositories/doctor/doctor_repository.dart';

part 'doctor_charges_event.dart';
part 'doctor_charges_state.dart';

class DoctorChargesBloc extends Bloc<DoctorChargesEvent, DoctorChargesState> {
  final DoctorRepository doctorRepository;
  DoctorChargesBloc({required DoctorRepository doctorRepository})
      : doctorRepository = doctorRepository,
        super(DoctorChargesInitial()) {
    on<LoadDoctorCharges>(_onLoadDoctorCharges);
    on<SetDoctorCharges>(_onSetDoctorCharges);
  }
  void _onLoadDoctorCharges(
      LoadDoctorCharges event, Emitter<DoctorChargesState> emit) async {
    emit(DoctorChargesLoading());
    try {
      DoctorChargesModel charges =
          await doctorRepository.getDoctorCharges(doctorId: event.doctorId);
      emit(DoctorChargesLoaded(charges: charges));
    } catch (error) {
      String errorMessage = error.toString().split(':').last;
      emit(DoctorChargesLoadError(message: errorMessage));
    }
  }

  void _onSetDoctorCharges(
      SetDoctorCharges event, Emitter<DoctorChargesState> emit) async {
    emit(DoctorChargesLoading());
    try {
      final message = await doctorRepository.addDoctorCharges(
          doctorId: event.doctorId,
          chatCost: event.chatCost,
          videoCallCost: event.videoCallCost,
          phoneCallCost: event.phoneCallCost);
      print(message);
      DoctorChargesModel charges =
          await doctorRepository.getDoctorCharges(doctorId: event.doctorId);
      emit(DoctorChargesLoaded(charges: charges));
    } catch (error) {
      String errorMessage = error.toString().split(':').last;
      emit(DoctorChargesLoadError(message: errorMessage));
    }
  }
}
