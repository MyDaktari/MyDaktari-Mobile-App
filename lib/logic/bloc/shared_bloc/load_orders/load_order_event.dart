part of 'load_order_bloc.dart';

abstract class LoadOrderEvent extends Equatable {
  const LoadOrderEvent();

  @override
  List<Object> get props => [];
}

class LoadOrders extends LoadOrderEvent {
  final String userId;
  const LoadOrders({required this.userId});
  @override
  List<Object> get props => [userId];
}
