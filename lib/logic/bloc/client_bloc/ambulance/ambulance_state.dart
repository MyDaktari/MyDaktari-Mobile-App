part of 'ambulance_bloc.dart';

abstract class AmbulanceState extends Equatable {
  const AmbulanceState();

  @override
  List<Object> get props => [];
}

class AmbulanceLoading extends AmbulanceState {}

class AmbulanceLoaded extends AmbulanceState {
  final List<AmbulanceModel> ambulances;

  const AmbulanceLoaded({this.ambulances = const <AmbulanceModel>[]});
  @override
  List<Object> get props => [ambulances];
}

class AmbulanceLoadingError extends AmbulanceState {
  final String message;

  const AmbulanceLoadingError({required this.message});
  @override
  List<Object> get props => [message];
}
