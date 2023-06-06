import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/models/symptom_model.dart';
import 'package:my_daktari/repositories/symptoms/symptoms_repository.dart';

part 'symptoms_event.dart';
part 'symptoms_state.dart';

class SymptomsBloc extends Bloc<SymptomsEvent, SymptomsState> {
  SymptomsRepository _symptomsRepository;
  SymptomsBloc({required SymptomsRepository symptomsRepository})
      : _symptomsRepository = symptomsRepository,
        super(SymptomsLoading()) {
    on<LoadSymptoms>(_onLoadSymptoms);
    on<SelectSymptom>(_onSelectSymptom);
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

  void _onSelectSymptom(
      SelectSymptom event, Emitter<SymptomsState> emit) async {
    emit(SymptomsLoading());
    try {
      List<Symptoms> selectedSymptoms =
          List.from((state as SymptomsLoaded).selectedSymptoms);
      selectedSymptoms.add(event.symptom);
      SymptomsLoaded newState = (state as SymptomsLoaded)
          .copyWith(selectedSymptoms: selectedSymptoms);
      emit(newState);
    } catch (error) {
      String errorMessage = error.toString().split(':').last;
      emit(SymptomsLoadingError(message: errorMessage));
    }
  }
}
