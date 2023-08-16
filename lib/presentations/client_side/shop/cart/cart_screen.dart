import 'package:flutter/material.dart';

import 'cart_item.dart';
import '../product.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Items'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        child: ListView.builder(
          itemCount: dummyProducts.length - 5, // Number of cart items
          itemBuilder: (context, index) {
            return CartItem(product: dummyProducts[index]);
          },
        ),
      ),
    );
  }
}
