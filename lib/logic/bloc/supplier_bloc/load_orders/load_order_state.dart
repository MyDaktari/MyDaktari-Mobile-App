part of 'load_order_bloc.dart';

abstract class LoadOrderState extends Equatable {
  const LoadOrderState();

  @override
  List<Object> get props => [];
}

class LoadOrderInitial extends LoadOrderState {}

class LoadOrderLoading extends LoadOrderState {}

class LoadOrderSuccess extends LoadOrderState {
  final List<SupplierOrderModel> orders;
  const LoadOrderSuccess({required this.orders});
  @override
  List<Object> get props => [orders];
}

class LoadOrderFailed extends LoadOrderState {
  final String message;
  const LoadOrderFailed({required this.message});
  @override
  List<Object> get props => [message];
}
