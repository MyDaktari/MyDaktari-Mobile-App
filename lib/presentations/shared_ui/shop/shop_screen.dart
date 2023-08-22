import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/constants/colors.dart';
import 'package:my_daktari/presentations/widgets/custom_loading.dart';
import '../../../constants/route.dart' as route;

import '../../../logic/bloc/shared_bloc/load_products/load_products_bloc.dart';
import 'widgets/product_card.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bankground,
      appBar: AppBar(
          title: Text('Shop', style: TextStyle(color: AppColor.primaryColor)),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(route.cartScreen);
                },
                icon: const Icon(Icons.shopping_cart_outlined),
                color: AppColor.primaryColor),
          ],
          elevation: 0,
          backgroundColor: AppColor.bankground),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search Items',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(color: Colors.grey, width: 2),
                ),
                suffixIcon: const Icon(Icons.search),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('All Items',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Icon(Icons.filter_list),
                    SizedBox(width: 4),
                    Text('Filter',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                        width: 8), // Add spacing between Filter and Sort by
                    Icon(Icons.compare_arrows_outlined),
                    SizedBox(width: 4),
                    Text('Sort by',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
              ],
            ),
          ),
          BlocBuilder<LoadProductsBloc, LoadProductsState>(
            builder: (context, state) {
              if (state is ProductsLoading) {
                return Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: CustomLoading(),
                  ),
                );
              } else if (state is ProductsLoaded) {
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async =>
                        context.read<LoadProductsBloc>().add(LoadProducts()),
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                      ),
                      itemCount:
                          state.products.length, // Number of product cards
                      itemBuilder: (context, index) {
                        return ProductCard(product: state.products[index]);
                      },
                    ),
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
                        onPressed: () => context
                            .read<LoadProductsBloc>()
                            .add(LoadProducts()),
                        child: Text('Refresh'))
                  ],
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
