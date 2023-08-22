import 'package:flutter/material.dart';
import 'package:my_daktari/constants/colors.dart';

import 'widgets/order_Item.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Orders'),
      ),
      body: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            border: Border.all(color: AppColor.bankground),
            borderRadius: BorderRadius.circular(10)),
        child: ListView.builder(
          itemCount: 5, // Number of orders
          itemBuilder: (context, index) {
            return OrderItem();
          },
        ),
      ),
    );
  }
}
