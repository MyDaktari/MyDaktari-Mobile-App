import 'package:flutter/material.dart';
import 'package:my_daktari/constants/colors.dart';
import 'package:my_daktari/presentations/supplier_side/add_product/widget/custom_textfield.dart';
import 'package:my_daktari/presentations/supplier_side/add_product/widget/multi_line_textfield.dart';

import 'widget/upload_images.dart';

class UploadProductScreen extends StatelessWidget {
  const UploadProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.bankground,
        appBar: AppBar(
            title: Text('Upload Product',
                style: TextStyle(color: AppColor.blackText)),
            backgroundColor: AppColor.bankground,
            elevation: 0,
            leading: IconButton(
                icon: Icon(Icons.arrow_back, color: AppColor.blackText),
                onPressed: () => Navigator.of(context).pop())),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Divider(thickness: 1),
                Text('Basic Information:',
                    style: TextStyle(
                        color: AppColor.blackText,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                UploadProductImages(),
                CustomTextField(hintText: 'Product Name'),
                MultiLineTextField(hintText: 'Product Description'),
                CustomTextField(hintText: 'Product Price (ksh)'),
                CustomTextField(
                    hintText: 'Product Variations(Colors, Sizes, etc.)'),
                SizedBox(height: 10),
                Text('Additional Information:',
                    style: TextStyle(
                        color: AppColor.blackText,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                CustomTextField(hintText: 'Product tags/keywords'),
                CustomTextField(hintText: 'Product Highlights'),
                MultiLineTextField(
                  hintText:
                      'Product specifications(dimensions, weight, material used, and any technical specifications etc.)',
                ),
                MultiLineTextField(
                    hintText:
                        'Shipping Information (shipping methods, delivery times, and associated costs)'),
              ],
            ),
          ),
        ));
  }
}
