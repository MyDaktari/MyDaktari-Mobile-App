import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../constants/route.dart' as route;
import '../../../../logic/bloc/shared_bloc/cart/cart_bloc.dart';
import '../../../../models/product.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route.productScreen, arguments: product);
      },
      child: Container(
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 4,
                offset: const Offset(0, 2)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 140,
              width: double.infinity,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
              child: CachedNetworkImage(
                  placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(strokeWidth: 1)),
                  errorWidget: (context, url, error) => const Icon(
                      Icons.error_outline,
                      size: 54,
                      color: Colors.red),
                  imageUrl: product.productsImages!.first.toString(),
                  fit: BoxFit.cover),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.productName.toString(),
                      maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text(
                    'Kshs ${product.productPrice.toString()}',
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: BlocBuilder<CartBloc, CartState>(
                      builder: (context, state) {
                        if (state is CartLoaded) {
                          return InkWell(
                            onTap: () {
                              Fluttertoast.showToast(msg: 'Added to cart');
                              context
                                  .read<CartBloc>()
                                  .add(AddProductToCart(product: product));
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Add to Cart',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700)),
                                const SizedBox(width: 8),
                                Container(
                                    color: Colors.grey, height: 20, width: 2),
                                const SizedBox(width: 8),
                                const Icon(
                                    Icons.shopping_cart_checkout_outlined,
                                    color: Colors.white),
                              ],
                            ),
                          );
                        } else {
                          return CupertinoActivityIndicator(
                              color: Colors.white);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
