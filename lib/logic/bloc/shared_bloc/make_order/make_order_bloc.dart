import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../models/suborder_model.dart';
import '../../../../repositories/shared_repositories/shop/shop_repository.dart';

part 'make_order_event.dart';
part 'make_order_state.dart';

class MakeOrderBloc extends Bloc<MakeOrderEvent, MakeOrderState> {
  final ShopRepository _paymentRepository;
  MakeOrderBloc({required ShopRepository paymentRepository})
      : _paymentRepository = paymentRepository,
        super(MakeOrderInitial()) {
    on<PlaceOrder>(_onMakeOrder);
  }
  void _onMakeOrder(PlaceOrder event, Emitter<MakeOrderState> emit) async {
    try {
      emit(MakeOrderLoading());
      Map<String, String> mapResponse = await _paymentRepository.placeOrder(
          userId: event.userID,
          phoneNumber: event.phoneNumber,
          address: event.address,
          optionalInfo: event.additionalInfo,
          totalAmount: event.totalAmount,
          products: event.products);
      emit(MakeOrderSuccess(
          successMessage: mapResponse['message'].toString(),
          orderID: mapResponse['orderID'].toString()));
    } catch (error) {
      final message = error.toString().contains("host lookup")
          ? 'Connect to the internet '
          : error.toString().split("Exception:").last;
      emit(MakeOrderFailure(errorMessage: message));
    }
  }
}
