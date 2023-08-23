part of 'load_order_bloc.dart';

abstract class LoadOrderEvent extends Equatable {
  const LoadOrderEvent();

  @override
  List<Object> get props => [];
}

class LoadOrder extends LoadOrderEvent {
  final String supplierId;
  const LoadOrder({required this.supplierId});
  @override
  List<Object> get props => [supplierId];
}
