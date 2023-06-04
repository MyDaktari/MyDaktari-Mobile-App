import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/mock/models/symptom_model.dart';

import '../../../repositories/symptoms/symptoms_repository.dart';

part 'symptoms_event.dart';
part 'symptoms_state.dart';

class SymptomsBloc extends Bloc<SymptomsEvent, SymptomsState> {
  SymptomsRepository _symptomsRepository;
  SymptomsBloc({required SymptomsRepository symptomsRepository})
      : _symptomsRepository = symptomsRepository,
        super(SymptomsLoading()) {
    on<LoadSymptoms>(_onLoadSymptoms);
  }
  void _onLoadSymptoms(LoadSymptoms event, Emitter<SymptomsState> emit) async {
    emit(SymptomsLoading());
    try {
      List<SymptomModel>? symptoms =
          await _symptomsRepository.getSymptoms(event.query);
      emit(SymptomsLoaded(symptoms: symptoms));
    } catch (error) {
      String errorMessage = error.toString().split(':').last;
      emit(SymptomsLoadingError(message: errorMessage));
    }
  }
}
