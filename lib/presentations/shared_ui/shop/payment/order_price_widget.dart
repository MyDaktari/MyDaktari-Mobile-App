import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';
import '../../../../models/cart_model.dart';

class OrderPriceWidget extends StatelessWidget {
  const OrderPriceWidget({
    super.key,
    required this.cartModel,
  });
  final CartModel cartModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Subtotal (incl. of vat)',
                      style: TextStyle(fontSize: 16)),
                  Text('Ksh ${cartModel.subtotal}',
                      style: const TextStyle(fontSize: 16))
                ],
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Delivery fee', style: TextStyle(fontSize: 16)),
                  Text('Ksh ${cartModel.shippingFee}',
                      style: const TextStyle(fontSize: 16))
                ],
              ),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(4.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  Text('Ksh ${cartModel.totalAmountString}',
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColor.primaryColor,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
