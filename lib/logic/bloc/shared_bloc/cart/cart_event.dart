part of 'cart_bloc.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
  @override
  List<Object> get props => [];
}

class StartCart extends CartEvent {
  @override
  List<Object> get props => [];
}

class AddProductToCart extends CartEvent {
  final ProductModel product;
  const AddProductToCart({required this.product});
  @override
  List<Object> get props => [product];
}

class RemoveProductFromCart extends CartEvent {
  final ProductModel product;
  const RemoveProductFromCart({required this.product});

  @override
  List<Object> get props => [product];
}

class DeleteProductFromCart extends CartEvent {
  final ProductModel product;
  const DeleteProductFromCart({required this.product});
  @override
  List<Object> get props => [product];
}

class ClearCart extends CartEvent {
  @override
  List<Object> get props => [];
}
