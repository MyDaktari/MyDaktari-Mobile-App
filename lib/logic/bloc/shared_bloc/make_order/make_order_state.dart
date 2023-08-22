part of 'make_order_bloc.dart';

abstract class MakeOrderState extends Equatable {
  const MakeOrderState();

  @override
  List<Object> get props => [];
}

class MakeOrderInitial extends MakeOrderState {}

class MakeOrderLoading extends MakeOrderState {}

class MakeOrderSuccess extends MakeOrderState {
  final String successMessage;
  final String orderID;
  const MakeOrderSuccess({required this.successMessage, required this.orderID});
  @override
  List<Object> get props => [successMessage, orderID];
}

class MakeOrderFailure extends MakeOrderState {
  final String errorMessage;
  const MakeOrderFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
