import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/constants/colors.dart';
import 'package:my_daktari/logic/bloc/shared_bloc/cart/cart_bloc.dart';
import 'package:my_daktari/presentations/widgets/custom_loading.dart';

import '../../../../models/product.dart';
import '../../../../models/suborder_model.dart';
import 'cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart Items')),
      body: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.lightGrey),
            borderRadius: BorderRadius.circular(10)),
        child: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            if (state is CartLoading) {
              return Expanded(child: CustomLoading());
            } else if (state is CartLoaded) {
              // get the map of product quantities
              Map<dynamic, dynamic> productQuantities =
                  state.cart.productQuantity(state.cart.products);
              // get the list of products in the cart
              List<dynamic> productsInCart = productQuantities.keys.toList();

              // loop through the list of products and their quantities
              List<SubOrdersModel> cartItems =
                  []; // List to store the cart items

              for (int i = 0; i < productsInCart.length; i++) {
                ProductModel product = productsInCart[i];
                int quantity = productQuantities[product];
                double price =
                    double.parse(product.productPrice.toString()) * quantity;

                // Create the SubOrdersModel for the current product
                SubOrdersModel item = SubOrdersModel(
                  productId: product.productID.toString(),
                  quantity: quantity.toString(),
                  totalPrice: price.toString(),
                );
                // Add the SubOrdersModel to the list of cart items
                cartItems.add(item);
              }

              return Visibility(
                replacement: Center(
                    child: Text(
                  'No items in cart',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )),
                visible: state.cart
                    .productQuantity(state.cart.products)
                    .keys
                    .isNotEmpty,
                child: ListView.builder(
                  itemCount: state.cart
                      .productQuantity(state.cart.products)
                      .keys
                      .length, // Number of cart items
                  itemBuilder: (context, index) {
                    return CartItem(
                      product: state.cart
                          .productQuantity(state.cart.products)
                          .keys
                          .elementAt(index),
                      productQuantity: state.cart
                          .productQuantity(state.cart.products)
                          .values
                          .elementAt(index),
                    );
                  },
                ),
              );
            } else {
              return Container(
                child: Center(
                  child: Text('Something went wrong!'),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
