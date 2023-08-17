import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/colors.dart';
import '../../../../constants/constants.dart';
import '../../../../logic/bloc/shared_bloc/load_products/load_products_bloc.dart';
import '../widget/summary_card.dart';
import '../widget/supplier_home_button.dart';
import '../widget/supplier_profile_header.dart';
import '../../../../constants/route.dart' as route;

class SupplierHomePage extends StatelessWidget {
  const SupplierHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          SupplierProfileHeader(),
          SizedBox(height: 10),
          Divider(thickness: 1),
          SummaryCard(
              color: AppColor.primaryColor,
              tite: 'Products Listed',
              value: '35',
              width: double.infinity),
          Row(
            children: [
              Expanded(
                  child: SummaryCard(
                      color: AppColor.pick,
                      tite: 'Total Orders Received',
                      value: '12')),
              SizedBox(width: 10),
              Expanded(
                  child: SummaryCard(
                      color: AppColor.darkOrange,
                      tite: 'Conversion Rate',
                      value: '56 %')),
            ],
          ),
          SizedBox(height: 10),
          Divider(),
          SizedBox(height: 10),
          SupplierHomeButton(
              title: 'Upload Products',
              onTap: () =>
                  Navigator.pushNamed(context, route.uploadProductScreen),
              color: AppColor.primaryColor,
              icon: Icons.file_upload_outlined),
          SupplierHomeButton(
              title: 'Product Catalog',
              onTap: () {
                context.read<LoadProductsBloc>().add(LoadSupplierProducts(
                    supplierId: supplier.supplierID.toString()));
                Navigator.pushNamed(
                    context, route.supplierProductCatalogueScreen);
              },
              color: AppColor.darkOrange,
              icon: Icons.production_quantity_limits),
          SupplierHomeButton(
            title: 'Orders',
            color: AppColor.green,
            icon: Icons.list_alt,
            onTap: () => Navigator.pushNamed(context, 'Orders'),
          ),
        ],
      ),
    );
  }
}
