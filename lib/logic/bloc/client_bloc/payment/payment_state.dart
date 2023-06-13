// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'payment_bloc.dart';

abstract class PaymentState extends Equatable {
  const PaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentSuccess extends PaymentState {
  final String successMessage;
  const PaymentSuccess({required this.successMessage});
  @override
  List<Object> get props => [successMessage];
}

class PaymentFailure extends PaymentState {
  final String errorMessage;
  const PaymentFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
