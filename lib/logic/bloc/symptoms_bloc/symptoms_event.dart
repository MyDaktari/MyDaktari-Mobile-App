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
