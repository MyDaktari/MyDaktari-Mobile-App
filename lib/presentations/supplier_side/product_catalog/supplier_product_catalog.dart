import 'package:flutter/material.dart';
import 'package:my_daktari/constants/colors.dart';
import 'package:my_daktari/presentations/supplier_side/product_catalog/product_card.dart';

class SupplierProductCatalogScreen extends StatelessWidget {
  const SupplierProductCatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.bankground,
        appBar: AppBar(
            title: Text('Product Catalog',
                style: TextStyle(color: AppColor.blackText)),
            backgroundColor: AppColor.bankground,
            elevation: 0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: AppColor.blackText),
                onPressed: () => Navigator.of(context).pop())),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView.builder(
            itemCount: 10,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (context, index) => SupplierProductCard(),
          ),
        ));
  }
}
