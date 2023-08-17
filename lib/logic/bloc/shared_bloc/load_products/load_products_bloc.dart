import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/product.dart';
import '../../../../repositories/supplier/product/product_repository.dart';
part 'load_products_event.dart';
part 'load_products_state.dart';

class LoadProductsBloc extends Bloc<ProductsByBrandEvent, LoadProductsState> {
  final ProductRepository _productsRepository;

  LoadProductsBloc({required ProductRepository productsRepository})
      : _productsRepository = productsRepository,
        super(ProductsLoading()) {
    on<LoadSupplierProducts>(_onLoadSupplierProducts);
    on<LoadProducts>(_onLoadByBrand);
  }

  void _onLoadSupplierProducts(
      LoadSupplierProducts event, Emitter<LoadProductsState> emit) async {
    try {
      emit(ProductsLoading());
      List<ProductModel> products = await _productsRepository
          .getSupplierProducts(supplierId: event.supplierId);
      emit(ProductsLoaded(products: products));
    } catch (error) {
      print(error.toString());
      emit(ProductsLoadError(errorMessage: error.toString()));
    }
  }

  void _onLoadByBrand(
      LoadProducts event, Emitter<LoadProductsState> emit) async {
    try {
      emit(ProductsLoading());
      List<ProductModel> products =
          await _productsRepository.getProductCatalogue();
      emit(ProductsLoaded(products: products));
    } catch (error) {
      print(error.toString());
      emit(ProductsLoadError(errorMessage: error.toString()));
    }
  }
}
