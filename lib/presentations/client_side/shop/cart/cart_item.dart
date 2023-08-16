import 'package:flutter/material.dart';

import '../product.dart';

class CartItem extends StatelessWidget {
  final Product product;
  const CartItem({Key? key, required this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
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
                  child: Image.network(product.imageUrl, fit: BoxFit.cover)),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(product.productName),
                  const SizedBox(height: 8),
                  Container(
                    width: 80,
                    height: 40,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.withOpacity(0.5)),
                        borderRadius: BorderRadius.circular(10)),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(child: Icon(Icons.remove, size: 16)),
                        Expanded(
                          child: TextField(
                            style: TextStyle(fontSize: 12),
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            decoration:
                                InputDecoration(border: InputBorder.none),
                          ),
                        ),
                        Expanded(child: Icon(Icons.add, size: 16))
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(width: 16),
              Text('Kshs ${product.price}'),
              const SizedBox(width: 16),
              SizedBox(
                height: 80,
                child: Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    child: Image.asset('assets/images/trash.png'),
                    onTap: () {},
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
