import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/models/product.dart';

import '../../../../logic/bloc/shared_bloc/cart/cart_bloc.dart';

class CartItem extends StatelessWidget {
  final ProductModel product;
  final int productQuantity;
  const CartItem(
      {Key? key, required this.product, required this.productQuantity})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    clipBehavior: Clip.antiAlias,
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: CachedNetworkImage(
                      placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(strokeWidth: 1)),
                      errorWidget: (context, url, error) => const Icon(
                          Icons.error_outline,
                          size: 54,
                          color: Colors.red),
                      imageUrl: product.productsImages!.first.toString(),
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(product.productName.toString()),
                        const SizedBox(height: 8),
                        Container(
                          width: 80,
                          height: 40,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.5)),
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                  child: GestureDetector(
                                      onTap: () => context.read<CartBloc>().add(
                                          RemoveProductFromCart(
                                              product: product)),
                                      child: Icon(Icons.remove, size: 16))),
                              Expanded(
                                  child: Text('$productQuantity',
                                      textAlign: TextAlign.center)),
                              Expanded(
                                  child: GestureDetector(
                                      onTap: () => context.read<CartBloc>().add(
                                          AddProductToCart(product: product)),
                                      child: Icon(Icons.add, size: 16)))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                      child: Text('ksh\n${product.productPrice.toString()}',
                          textAlign: TextAlign.center)),
                ],
              ),
              SizedBox(
                height: 80,
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    child: Image.asset('assets/images/trash.png'),
                    onTap: () {
                      context
                          .read<CartBloc>()
                          .add(DeleteProductFromCart(product: product));
                    },
                  ),
                ),
              ),
            ],
          ),
          Divider(
              endIndent: 16, indent: 16, color: Colors.grey.withOpacity(0.5))
        ],
      ),
    );
  }
}
