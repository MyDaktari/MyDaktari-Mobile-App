import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_daktari/constants/colors.dart';
import 'package:my_daktari/logic/bloc/shared_bloc/cart/cart_bloc.dart';

import '../../../models/product.dart';
import 'widgets/rating.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _currentPage = 0;
  Widget buildDot({required int index}) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      margin: const EdgeInsets.only(right: 5),
      height: 8,
      width: _currentPage == index ? 20 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index ? Colors.blue : Colors.grey,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
          title: Text('Product Detail',
              style: TextStyle(color: AppColor.primaryColor))),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: 250,
              margin: const EdgeInsets.all(10),
              clipBehavior: Clip.antiAlias,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(16)),
              child: Stack(
                children: [
                  PageView.builder(
                    itemCount: widget.product.productsImages!.length,
                    onPageChanged: (index) {
                      setState(() {
                        _currentPage = index;
                      });
                    },
                    itemBuilder: (context, index) {
                      return CachedNetworkImage(
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(strokeWidth: 1),
                        ),
                        errorWidget: (context, url, error) => const Icon(
                            Icons.error_outline,
                            size: 54,
                            color: Colors.red),
                        imageUrl:
                            widget.product.productsImages![index].toString(),
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  Visibility(
                    visible: widget.product.productsImages!.length > 1,
                    child: Positioned(
                      bottom: 10,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                            widget.product.productsImages!.length,
                            (index) => buildDot(index: index)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.product.productName.toString(),
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('Kshs. ${widget.product.productPrice.toString()}',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold)),
                  const SizedBox(height: 16),
                  const Text('Product Details',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(widget.product.productDescription.toString()),
                  const SizedBox(height: 16),
                  Divider(thickness: 1),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Product Review',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Row(
                        children: [
                          ...buildStarRating(2),
                          // Text(
                          //   product.rating.toString(),
                          //   style: const TextStyle(
                          //       color: Colors.black,
                          //       fontSize: 17,
                          //       fontWeight: FontWeight.bold),
                          // ),
                        ],
                      )
                    ],
                  ),
                  Divider(thickness: 1),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      // Handle add to cart action
                      Fluttertoast.showToast(msg: 'Added to cart');
                      context
                          .read<CartBloc>()
                          .add(AddProductToCart(product: widget.product));
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                        fixedSize: Size(size.width * .9, 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        padding: const EdgeInsets.all(5)),
                    child: const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        child: Text('Add to Cart',
                            style:
                                TextStyle(fontSize: 16, color: Colors.white))),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
