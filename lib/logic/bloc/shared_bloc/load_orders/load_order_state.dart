part of 'load_order_bloc.dart';

abstract class OrderState extends Equatable {
  const OrderState();

  @override
  List<Object> get props => [];
}

class OrderInitial extends OrderState {}

class OrdersLoading extends OrderState {}

class OrderLoadSuccess extends OrderState {
  final List<SupplierOrderModel> orders;
  const OrderLoadSuccess({required this.orders});
  @override
  List<Object> get props => [orders];
}

class OrdersLoadinFailed extends OrderState {
  final String message;
  const OrdersLoadinFailed({required this.message});
  @override
  List<Object> get props => [message];
}
