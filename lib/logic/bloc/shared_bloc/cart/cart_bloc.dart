import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/cart_model.dart';
import '../../../../models/product.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartLoading()) {
    on<StartCart>(_onStartCart);
    on<AddProductToCart>(_onAddProductToCart);
    on<RemoveProductFromCart>(_onRemoveProductFromCart);
    on<DeleteProductFromCart>(_onDeleteProductFromCart);
    on<ClearCart>(_onClearCart);
  }
  void _onStartCart(event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const CartLoaded());
    } catch (_) {}
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) async {
    emit(CartLoading());
    try {
      // Simulate an asynchronous operation
      await Future<void>.delayed(const Duration(seconds: 1));
      emit(const CartLoaded(cart: CartModel(products: [])));
    } catch (_) {}
  }

  void _onAddProductToCart(
      AddProductToCart event, Emitter<CartState> emit) async {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        emit(
          CartLoaded(
            cart: CartModel(
                products: List.from(state.cart.products)..add(event.product)),
          ),
        );
      } catch (_) {}
    }
  }

  void _onRemoveProductFromCart(
      RemoveProductFromCart event, Emitter<CartState> emit) async {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        emit(
          CartLoaded(
            cart: CartModel(
                products: List.from(state.cart.products)
                  ..remove(event.product)),
          ),
        );
      } catch (_) {}
    }
  }

  void _onDeleteProductFromCart(
      DeleteProductFromCart event, Emitter<CartState> emit) async {
    final state = this.state;
    if (state is CartLoaded) {
      try {
        emit(
          CartLoaded(
            cart: CartModel(
                products: List.from(state.cart.products)
                  ..removeWhere((product) =>
                      product.productID == event.product.productID)),
          ),
        );
      } catch (_) {}
    }
  }
}
