part of 'ambulance_bloc.dart';

abstract class AmbulanceEvent extends Equatable {
  const AmbulanceEvent();

  @override
  List<Object> get props => [];
}

class LoadAmbulances extends AmbulanceEvent {}
