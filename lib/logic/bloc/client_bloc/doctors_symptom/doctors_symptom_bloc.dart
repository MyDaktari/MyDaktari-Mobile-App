import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_daktari/models/doctor_profile_model.dart';
import 'package:my_daktari/repositories/client/client_repository.dart';

part 'doctors_symptom_event.dart';
part 'doctors_symptom_state.dart';

class DoctorsBySymptomsBloc
    extends Bloc<DoctorsBySymptomsEvent, DoctorsBySymptomsState> {
  final ClientRepository repository;
  DoctorsBySymptomsBloc({required ClientRepository repository})
      : repository = repository,
        super(DoctorsBySymptomsInitialized()) {
    on<SearchDoctorsBySymptoms>(_onSearchDoctors);
  }
  void _onSearchDoctors(SearchDoctorsBySymptoms event,
      Emitter<DoctorsBySymptomsState> emit) async {
    try {
      List<DoctorProfileModel> doctors =
          await repository.showDoctorsBySyptoms(event.symptomId);
      emit(DoctorsBySymptomsLoaded(doctors: doctors));
    } catch (error) {
      String errorMessage = error.toString().split(':').last;
      emit(DoctorsBySymptomsLoadError(errorMessage: errorMessage));
    }
  }
}
