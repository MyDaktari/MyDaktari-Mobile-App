import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/models/supplier_order_model.dart';

import '../../../../repositories/supplier/product/product_repository.dart';

part 'load_order_event.dart';
part 'load_order_state.dart';

class SupplierOrdersBloc
    extends Bloc<LoadSupplierOrderEvent, LoadSupplierOrderState> {
  final ProductRepository productRepository;
  SupplierOrdersBloc({required ProductRepository repository})
      : productRepository = repository,
        super(LoadSupplierOrderInitial()) {
    on<LoadSupplierOrders>(_onLoadOrder);
  }
  void _onLoadOrder(
      LoadSupplierOrders event, Emitter<LoadSupplierOrderState> emit) async {
    emit(LoadSupplierOrderLoading());
    try {
      List<SupplierOrderModel> orders = await productRepository
          .getSupplierOrders(supplierId: event.supplierId);
      emit(LoadSupplierOrderSuccess(orders: orders));
    } catch (error) {
      final message = error.toString().contains("host lookup")
          ? 'Connect to the internet '
          : error.toString().split("Exception:").last;
      emit(LoadSupplierOrderFailed(message: message));
    }
  }
}
