part of 'pharmacy_bloc.dart';

abstract class PharmacyState extends Equatable {
  const PharmacyState();

  @override
  List<Object> get props => [];
}

class PharmacyLoading extends PharmacyState {}

class PharmacyLoaded extends PharmacyState {
  final List<PharmacyModel> pharmacyList;

  const PharmacyLoaded({this.pharmacyList = const <PharmacyModel>[]});
  @override
  List<Object> get props => [pharmacyList];
}

class PharmacyLoadingError extends PharmacyState {
  final String message;

  const PharmacyLoadingError({required this.message});
  @override
  List<Object> get props => [message];
}
