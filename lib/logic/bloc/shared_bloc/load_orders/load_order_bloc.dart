import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/supplier_order_model.dart';
import '../../../../repositories/supplier/product/product_repository.dart';

part 'load_order_event.dart';
part 'load_order_state.dart';

class OrderBloc extends Bloc<LoadOrderEvent, OrderState> {
  final ProductRepository productRepository;
  OrderBloc({required ProductRepository repository})
      : productRepository = repository,
        super(OrderInitial()) {
    on<LoadOrders>(_onLoadOrder);
  }
  void _onLoadOrder(LoadOrders event, Emitter<OrderState> emit) async {
    emit(OrdersLoading());
    try {
      List<SupplierOrderModel> orders =
          await productRepository.getSupplierOrders(supplierId: event.userId);
      emit(OrderLoadSuccess(orders: orders));
    } catch (error) {
      final message = error.toString().contains("host lookup")
          ? 'Connect to the internet '
          : error.toString().split("Exception:").last;
      emit(OrdersLoadinFailed(message: message));
    }
  }
}
