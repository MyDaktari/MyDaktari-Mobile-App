part of 'symptoms_bloc.dart';

abstract class SymptomsState extends Equatable {
  const SymptomsState();

  @override
  List<Object> get props => [];
}

class SymptomsLoading extends SymptomsState {}

class SymptomsLoaded extends SymptomsState {
  final List<SymptomModel> symptoms;

  const SymptomsLoaded({this.symptoms = const <SymptomModel>[]});
  @override
  List<Object> get props => [symptoms];
}

class SymptomsLoadingError extends SymptomsState {
  final String message;

  const SymptomsLoadingError({required this.message});
  @override
  List<Object> get props => [message];
}
