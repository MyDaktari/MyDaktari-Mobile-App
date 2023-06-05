part of 'symptoms_bloc.dart';

abstract class SymptomsEvent extends Equatable {
  const SymptomsEvent();

  @override
  List<Object> get props => [];
}

class LoadSymptoms extends SymptomsEvent {
  final Map<String, dynamic> query;
  const LoadSymptoms({required this.query});
  @override
  List<Object> get props => [query];
}

class SelectSymptom extends SymptomsEvent {
  final Symptoms symptom;
  const SelectSymptom({required this.symptom});
  @override
  List<Object> get props => [symptom];
}
