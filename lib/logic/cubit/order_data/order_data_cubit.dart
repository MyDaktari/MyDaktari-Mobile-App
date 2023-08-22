import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
part 'order_data_state.dart';

class OrderDataCubit extends Cubit<OrderDataState> {
  OrderDataCubit()
      : super(OrderDataState(
            userId: '', name: '', phone: '', address: '', additionalInfo: ''));

  void updateOrderData({
    String? userId,
    String? name,
    String? phone,
    String? address,
    String? additionalInfo,
  }) {
    emit(state.copyWith(
      userId: userId,
      name: name,
      phone: phone,
      address: address,
      additionalInfo: additionalInfo,
    ));
    {
      emit(state.copyWith(
        userId: userId,
        name: name,
        phone: phone,
        address: address,
        additionalInfo: additionalInfo,
      ));
    }
  }
}
