part of 'make_order_bloc.dart';

abstract class MakeOrderEvent extends Equatable {
  const MakeOrderEvent();

  @override
  List<Object> get props => [];
}

class PlaceOrder extends MakeOrderEvent {
  final String userID, phoneNumber, address, additionalInfo, totalAmount;
  final List<SubOrdersModel> products;
  const PlaceOrder(
      {required this.userID,
      required this.totalAmount,
      required this.phoneNumber,
      required this.address,
      required this.additionalInfo,
      required this.products});

  @override
  List<Object> get props =>
      [userID, phoneNumber, address, additionalInfo, products, totalAmount];
}
