import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_daktari/mock/models/symptom_model.dart';

part 'symptoms_cubit_state.dart';

class SymptomsCubit extends Cubit<SymptomsCubitState> {
  SymptomsCubit() : super(SymptomsCubitState(selectedSymptoms: <Symptoms>[]));

  void addSymptoms(Symptoms symptom) {
    final itemExists =
        state.selectedSymptoms.any((sym) => sym.symptomID == symptom.symptomID);
    if (itemExists) {
      state.selectedSymptoms
          .removeWhere((sym) => sym.symptomID == symptom.symptomID);
    } else {
      state.selectedSymptoms.add(symptom);
    }
    emit(SymptomsCubitState(selectedSymptoms: state.selectedSymptoms));
  }

  void clearSelectedSymptoms() {
    state.selectedSymptoms.clear();

    emit(SymptomsCubitState(selectedSymptoms: state.selectedSymptoms));
  }

  bool selected(Symptoms symptom) => state.containsSymptom(symptom);
}
