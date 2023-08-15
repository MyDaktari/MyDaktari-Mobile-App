import 'package:flutter/material.dart';
import 'package:my_daktari/presentations/supplier_side/home_screen/widget/supplier_profile_header.dart';

import '../../../constants/colors.dart';
import 'widget/summary_card.dart';
import 'widget/supplier_home_button.dart';

class SupplierHomeScreen extends StatelessWidget {
  const SupplierHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.bankground,
      body: SafeArea(
        child: Padding(
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
                  color: AppColor.primaryColor,
                  icon: Icons.file_upload_outlined),
              SupplierHomeButton(
                  title: 'Product Catalog',
                  color: AppColor.darkOrange,
                  icon: Icons.production_quantity_limits),
              SupplierHomeButton(
                  title: 'Orders', color: AppColor.green, icon: Icons.list_alt),
            ],
          ),
        ),
      ),
    );
  }
}
