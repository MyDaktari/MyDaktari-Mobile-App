part of 'symptoms_bloc.dart';

abstract class SymptomsState extends Equatable {
  const SymptomsState();

  @override
  List<Object> get props => [];
}

class SymptomsLoading extends SymptomsState {}

class SymptomsLoaded extends SymptomsState {
  final List<SymptomModel> symptoms;
  final List<Symptoms> selectedSymptoms;

  const SymptomsLoaded({
    this.symptoms = const <SymptomModel>[],
    this.selectedSymptoms = const <Symptoms>[],
  });

  SymptomsLoaded copyWith({
    List<SymptomModel>? symptoms,
    List<Symptoms>? selectedSymptoms,
  }) {
    return SymptomsLoaded(
      symptoms: symptoms ?? this.symptoms,
      selectedSymptoms: selectedSymptoms ?? this.selectedSymptoms,
    );
  }

  @override
  List<Object> get props => [symptoms, selectedSymptoms];
}

class SymptomsLoadingError extends SymptomsState {
  final String message;

  const SymptomsLoadingError({required this.message});
  @override
  List<Object> get props => [message];
}
