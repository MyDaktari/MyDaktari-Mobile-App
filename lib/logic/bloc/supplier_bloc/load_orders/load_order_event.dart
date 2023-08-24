part of 'load_order_bloc.dart';

abstract class LoadSupplierOrderEvent extends Equatable {
  const LoadSupplierOrderEvent();

  @override
  List<Object> get props => [];
}

class LoadSupplierOrders extends LoadSupplierOrderEvent {
  final String supplierId;
  const LoadSupplierOrders({required this.supplierId});
  @override
  List<Object> get props => [supplierId];
}
