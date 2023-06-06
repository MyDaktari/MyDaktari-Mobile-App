part of 'symptoms_cubit_cubit.dart';

class SymptomsCubitState extends Equatable {
  const SymptomsCubitState({required this.selectedSymptoms});
  final List<Symptoms> selectedSymptoms;

  @override
  List<Object> get props => [selectedSymptoms];
   bool containsSymptom(Symptoms symptom) =>
      selectedSymptoms.contains(symptom);
}
