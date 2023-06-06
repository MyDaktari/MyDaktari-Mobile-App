import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/repositories/doctor/doctor_repository.dart';

part 'complete_profile_event.dart';
part 'complete_profile_state.dart';

class CompleteProfileBloc
    extends Bloc<CompleteProfileEvent, CompleteProfileState> {
  final DoctorRepository doctorRepository;
  CompleteProfileBloc({required DoctorRepository doctorRepository})
      : doctorRepository = doctorRepository,
        super(CompleteProfileInitial()) {
    on<DoctorUpdateProfile>(_onDoctorUpdateProfile);
  }
  void _onDoctorUpdateProfile(
      DoctorUpdateProfile event, Emitter<CompleteProfileState> emit) async {
    emit(CompleteProfileLoading());
    try {
      // await doctorRepository.supply(
      //     name: event.name,
      //     email: event.email,
      //     productName: event.productName,
      //     supplierType: event.supplierType,
      //     platformFile: event.file);
      emit(CompleteProfileLoaded());
    } catch (error) {
      emit(CompleteProfileLoadError(message: error.toString()));
    }
  }
}
