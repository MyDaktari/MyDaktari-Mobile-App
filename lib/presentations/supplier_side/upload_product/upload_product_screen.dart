import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_daktari/constants/colors.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/logic/bloc/supplier_bloc/upload_product/upload_product_bloc.dart';
import 'package:my_daktari/logic/cubit/upload_product_data/upload_product_data_cubit.dart';
import 'package:my_daktari/presentations/supplier_side/upload_product/widget/custom_textfield.dart';
import 'package:my_daktari/presentations/supplier_side/upload_product/widget/multi_line_textfield.dart';
import 'package:my_daktari/presentations/widgets/success_dialogue.dart';

import 'widget/custom_category_textfield.dart';
import 'widget/upload_images.dart';

class UploadProductScreen extends StatelessWidget {
  UploadProductScreen({super.key});

  TextEditingController productName = TextEditingController();
  TextEditingController productDescription = TextEditingController();
  TextEditingController productCategory = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productQuantity = TextEditingController();
  TextEditingController productVariations = TextEditingController();
  TextEditingController productTags = TextEditingController();
  TextEditingController productHighlights = TextEditingController();
  TextEditingController productSpecifications = TextEditingController();
  TextEditingController productShipping = TextEditingController();

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
                CustomTextField(
                    hintText: 'Product Name', controller: productName),
                MultiLineTextField(
                    hintText: 'Product Description',
                    controller: productDescription),
                CustomCategoryTextField(
                    hintText: 'Product Category', controller: productCategory),
                UploadProductImages(),
                CustomTextField(
                    hintText: 'Product Price (ksh)',
                    number: true,
                    controller: productPrice),
                CustomTextField(
                    hintText: 'Product Quantity',
                    number: true,
                    controller: productQuantity),
                CustomTextField(
                    hintText: 'Product Variations(Colors, Sizes, etc.)',
                    controller: productVariations),
                SizedBox(height: 10),
                Text('Additional Information:',
                    style: TextStyle(
                        color: AppColor.blackText,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                CustomTextField(
                    hintText: 'Product tags/keywords', controller: productTags),
                CustomTextField(
                    hintText: 'Product Highlights',
                    controller: productHighlights),
                MultiLineTextField(
                  controller: productSpecifications,
                  hintText:
                      'Product specifications(dimensions, weight, material used, and any technical specifications etc.)',
                ),
                MultiLineTextField(
                    controller: productShipping,
                    hintText:
                        'Shipping Information (shipping methods, delivery times, and associated costs)'),
                SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(),
                        child:
                            Text('Cancel', style: TextStyle(color: Colors.red)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          fixedSize: Size(50, 50),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Colors.red)),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (productName.text.isNotEmpty &&
                              productDescription.text.isNotEmpty &&
                              productPrice.text.isNotEmpty &&
                              productQuantity.text.isNotEmpty &&
                              productVariations.text.isNotEmpty &&
                              productTags.text.isNotEmpty &&
                              productHighlights.text.isNotEmpty &&
                              productCategory.text.isNotEmpty &&
                              productSpecifications.text.isNotEmpty &&
                              productShipping.text.isNotEmpty) {
                            context.read<UploadProductBloc>().add(UploadProduct(
                                productName: productName.text,
                                productDescription: productDescription.text,
                                productPrice: productPrice.text,
                                productQuantity: productQuantity.text,
                                productVariations: productVariations.text,
                                productTags: productTags.text,
                                productHighlights: productHighlights.text,
                                productSpecifications:
                                    productSpecifications.text,
                                productCategory: productCategory.text,
                                supplierId: supplier.supplierID.toString(),
                                shippingInfo: productShipping.text,
                                imageFiles: context
                                    .read<UploadProductDataCubit>()
                                    .state
                                    .imageFiles));
                          } else {
                            Fluttertoast.showToast(
                                msg: 'All fields are required!');
                          }
                        },
                        child:
                            BlocConsumer<UploadProductBloc, UploadProductState>(
                          listener: (context, state) {
                            if (state is UploadProductSuccess) {
                              //show a success alert dialog
                              successDialog(
                                context: context,
                                message: 'Product uploaded successfully!',
                                title: 'MyDaktari',
                                success: true,
                              );
                            }
                            if (state is UploadProductFailed) {
                              successDialog(
                                context: context,
                                message:
                                    'Something went wrong!, try again! \nWe could not upload your product',
                                title: 'MyDaktari',
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is UploadProductLoading) {
                              return CupertinoActivityIndicator(
                                  color: Colors.white);
                            } else {
                              return Text('Success');
                            }
                          },
                        ),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(50, 50),
                          backgroundColor: AppColor.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20)
              ],
            ),
          ),
        ));
  }
}
