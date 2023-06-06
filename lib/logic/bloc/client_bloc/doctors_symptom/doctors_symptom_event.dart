part of 'doctors_symptom_bloc.dart';

abstract class DoctorsBySymptomsEvent extends Equatable {
  const DoctorsBySymptomsEvent();

  @override
  List<Object> get props => [];
}

class SearchDoctorsBySymptoms extends DoctorsBySymptomsEvent {
  final String symptomId;
  final BuildContext context;
  const SearchDoctorsBySymptoms(
      {required this.symptomId, required this.context});
  @override
  List<Object> get props => [symptomId, context];
}
