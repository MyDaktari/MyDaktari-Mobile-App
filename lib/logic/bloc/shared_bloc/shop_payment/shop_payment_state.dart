// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'shop_payment_bloc.dart';

abstract class ShopPaymentState extends Equatable {
  const ShopPaymentState();

  @override
  List<Object> get props => [];
}

class PaymentInitial extends ShopPaymentState {}

class PaymentLoading extends ShopPaymentState {}

class PaymentSuccess extends ShopPaymentState {
  final String successMessage;
  const PaymentSuccess({required this.successMessage});
  @override
  List<Object> get props => [successMessage];
}

class PaymentFailure extends ShopPaymentState {
  final String errorMessage;
  const PaymentFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
