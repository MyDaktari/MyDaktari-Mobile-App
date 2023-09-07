import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_daktari/models/product.dart';

import '../../../../logic/bloc/shared_bloc/cart/cart_bloc.dart';

class AddToCatButton extends StatelessWidget {
  const AddToCatButton({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        return (state is CartLoaded)
            ? state.cart.getProductQuantity(product) == 0
                ? InkWell(
                    onTap: () {
                      Fluttertoast.showToast(msg: 'Added to cart');
                      context
                          .read<CartBloc>()
                          .add(AddProductToCart(product: product));
                    },
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                          vertical: 6, horizontal: 12),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(5)),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Add to Cart',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700)),
                          const SizedBox(width: 8),
                          Container(color: Colors.grey, height: 20, width: 2),
                          const SizedBox(width: 8),
                          const Icon(Icons.shopping_cart_checkout_outlined,
                              color: Colors.white),
                        ],
                      ),
                    ),
                  )
                : Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            context
                                .read<CartBloc>()
                                .add(RemoveProductFromCart(product: product));
                          },
                          //check if quantity is =1 to change the icon design
                          child: state.cart.getProductQuantity(product) == 1
                              ? Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: const Icon(Icons.delete_forever,
                                      color: Colors.white),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(8)),
                                  child: const Icon(Icons.remove,
                                      color: Colors.white),
                                ),
                        ),
                        //text to desplay the quantity of the product once added to the cart
                        Text(state.cart.getProductQuantity(product).toString(),
                            style: Theme.of(context)
                                .textTheme
                                .displaySmall!
                                .copyWith(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                        //widget to the product to cart
                        InkWell(
                          onTap: () {
                            context
                                .read<CartBloc>()
                                .add(AddProductToCart(product: product));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8)),
                            child: const Icon(
                              Icons.add,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
            : const SizedBox();
      },
    );
  }
}
