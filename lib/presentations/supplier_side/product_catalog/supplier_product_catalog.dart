import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/constants/colors.dart';
import 'package:my_daktari/presentations/supplier_side/product_catalog/product_card.dart';
import 'package:my_daktari/presentations/widgets/custom_loading.dart';

import '../../../constants/constants.dart';
import '../../../logic/bloc/shared_bloc/load_products/load_products_bloc.dart';

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
          child: BlocBuilder<LoadProductsBloc, LoadProductsState>(
            builder: (context, state) {
              if (state is ProductsLoading) {
                return Center(child: CustomLoading());
              } else if (state is ProductsLoaded) {
                return RefreshIndicator(
                  onRefresh: () async => context.read<LoadProductsBloc>().add(
                      LoadSupplierProducts(
                          supplierId: supplier.supplierID.toString())),
                  child: GridView.builder(
                    itemCount: state.products.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10),
                    itemBuilder: (context, index) =>
                        SupplierProductCard(product: state.products[index]),
                  ),
                );
              } else {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(height: 100),
                    Center(
                        child: Text('No Products Found }}',
                            style: TextStyle(
                                color: AppColor.blackText,
                                fontSize: 20,
                                fontWeight: FontWeight.bold))),
                    //refresh
                    SizedBox(height: 20),
                    ElevatedButton(
                        onPressed: () => context.read<LoadProductsBloc>().add(
                            LoadSupplierProducts(
                                supplierId: supplier.supplierID.toString())),
                        child: Text('Refresh'))
                  ],
                );
              }
            },
          ),
        ));
  }
}
