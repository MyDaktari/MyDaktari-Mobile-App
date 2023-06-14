// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'payment_bloc.dart';

abstract class PaymentEvent extends Equatable {
  const PaymentEvent();

  @override
  List<Object> get props => [];
}

class MakePayment extends PaymentEvent {
  final String amount, appointmentID, userPhoneNumber;
  const MakePayment(
      {required this.amount,
      required this.appointmentID,
      required this.userPhoneNumber});

  @override
  List<Object> get props => [amount, appointmentID, userPhoneNumber];
}
