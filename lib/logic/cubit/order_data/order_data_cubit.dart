import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../models/suborder_model.dart';
part 'order_data_state.dart';

class OrderDataCubit extends Cubit<OrderDataState> {
  OrderDataCubit()
      : super(OrderDataState(
          userId: '',
          name: '',
          phone: '',
          address: '',
          additionalInfo: '',
          totalAmount: '',
          cartItems: [],
        ));

  void updateOrderData({
    String? userId,
    String? name,
    String? phone,
    String? address,
    String? additionalInfo,
    String? totalAmount,
    List<SubOrdersModel>? cartItems,
  }) {
    emit(state.copyWith(
      userId: userId,
      name: name,
      phone: phone,
      address: address,
      additionalInfo: additionalInfo,
      totalAmount: totalAmount,
      cartItems: cartItems,
    ));
    {
      emit(state.copyWith(
        userId: userId,
        name: name,
        phone: phone,
        address: address,
        additionalInfo: additionalInfo,
        totalAmount: totalAmount,
        cartItems: cartItems,
      ));
    }
  }
}
