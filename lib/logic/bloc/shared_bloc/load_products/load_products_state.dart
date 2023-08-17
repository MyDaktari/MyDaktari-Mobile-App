part of 'load_products_bloc.dart';

abstract class LoadProductsState extends Equatable {
  const LoadProductsState();

  @override
  List<Object> get props => [];
}

class ProductsLoading extends LoadProductsState {}

class ProductsLoaded extends LoadProductsState {
  final List<ProductModel> products;
  const ProductsLoaded({required this.products});
}

class ProductsLoadError extends LoadProductsState {
  final String errorMessage;

  const ProductsLoadError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
