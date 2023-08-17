part of 'load_products_bloc.dart';

abstract class ProductsByBrandEvent extends Equatable {
  const ProductsByBrandEvent();

  @override
  List<Object> get props => [];
}

class LoadSupplierProducts extends ProductsByBrandEvent {
  final String supplierId;
  const LoadSupplierProducts({required this.supplierId});
  @override
  List<Object> get props => [supplierId];
}

class LoadProducts extends ProductsByBrandEvent {
  const LoadProducts();
  @override
  List<Object> get props => [];
}
