part of 'pharmacy_bloc.dart';

abstract class PharmacyEvent extends Equatable {
  const PharmacyEvent();

  @override
  List<Object> get props => [];
}

class LoadPharmacy extends PharmacyEvent {}
