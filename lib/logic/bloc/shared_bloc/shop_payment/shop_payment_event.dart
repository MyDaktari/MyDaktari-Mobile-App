// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'shop_payment_bloc.dart';

abstract class ShopPaymentEvent extends Equatable {
  const ShopPaymentEvent();

  @override
  List<Object> get props => [];
}

class MakeShopPayment extends ShopPaymentEvent {
  final String amount, appointmentID, userPhoneNumber;
  const MakeShopPayment(
      {required this.amount,
      required this.appointmentID,
      required this.userPhoneNumber});

  @override
  List<Object> get props => [amount, appointmentID, userPhoneNumber];
}
