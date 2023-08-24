part of 'load_order_bloc.dart';

abstract class LoadSupplierOrderState extends Equatable {
  const LoadSupplierOrderState();

  @override
  List<Object> get props => [];
}

class LoadSupplierOrderInitial extends LoadSupplierOrderState {}

class LoadSupplierOrderLoading extends LoadSupplierOrderState {}

class LoadSupplierOrderSuccess extends LoadSupplierOrderState {
  final List<SupplierOrderModel> orders;
  const LoadSupplierOrderSuccess({required this.orders});
  @override
  List<Object> get props => [orders];
}

class LoadSupplierOrderFailed extends LoadSupplierOrderState {
  final String message;
  const LoadSupplierOrderFailed({required this.message});
  @override
  List<Object> get props => [message];
}
