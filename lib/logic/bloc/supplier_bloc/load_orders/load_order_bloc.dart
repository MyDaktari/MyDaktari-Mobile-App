import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/models/supplier_order_model.dart';

import '../../../../repositories/supplier/product/product_repository.dart';

part 'load_order_event.dart';
part 'load_order_state.dart';

class LoadOrderBloc extends Bloc<LoadOrderEvent, LoadOrderState> {
  final ProductRepository productRepository;
  LoadOrderBloc({required ProductRepository repository})
      : productRepository = repository,
        super(LoadOrderInitial()) {
    on<LoadOrder>(_onLoadOrder);
  }
  void _onLoadOrder(LoadOrder event, Emitter<LoadOrderState> emit) async {
    emit(LoadOrderLoading());
    try {
      List<SupplierOrderModel> orders = await productRepository
          .getSupplierOrders(supplierId: event.supplierId);
      emit(LoadOrderSuccess(orders: orders));
    } catch (error) {
      final message = error.toString().contains("host lookup")
          ? 'Connect to the internet '
          : error.toString().split("Exception:").last;
      emit(LoadOrderFailed(message: message));
    }
  }
}
