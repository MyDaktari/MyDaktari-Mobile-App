import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/constants/colors.dart';
import 'package:my_daktari/logic/bloc/shared_bloc/cart/cart_bloc.dart';
import 'package:my_daktari/logic/cubit/order_data/order_data_cubit.dart';
import 'package:my_daktari/presentations/widgets/custom_loading.dart';
import '../../../../constants/route.dart' as route;
import '../../../../models/product.dart';
import '../../../../models/suborder_model.dart';
import 'cart_item.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size; // Get the screen size
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
                    price: price.toString());
                // Add the SubOrdersModel to the list of cart items
                cartItems.add(item);
              }
              context
                  .read<OrderDataCubit>()
                  .updateOrderData(cartItems: cartItems);
              return Visibility(
                replacement: Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('No items in cart',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                  ],
                )),
                visible: state.cart
                    .productQuantity(state.cart.products)
                    .keys
                    .isNotEmpty,
                child: Column(
                  children: [
                    Expanded(
                      child: ScrollConfiguration(
                        behavior: ScrollBehavior(),
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
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to checkout screen
                        Navigator.pushNamed(
                            context, route.deliveryAddressScreen);
                      },
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(size.width * .6, 50),
                        backgroundColor: AppColor.primaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      child: Text('Checkout'),
                    ),
                  ],
                ),
              );
            } else {
              return Container(
                child: Center(
                  child: Text('Something went wrong!')
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
