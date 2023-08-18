import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/logic/bloc/supplier_bloc/load_categories/load_categories_bloc.dart';

import '../../../../constants/colors.dart';

class CustomCategoryTextField extends StatelessWidget {
  const CustomCategoryTextField(
      {Key? key, required this.hintText, required this.controller})
      : super(key: key);

  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppColor.lightGrey),
      child: BlocBuilder<LoadCategoriesBloc, LoadCategoriesState>(
        builder: (context, state) {
          if (state is CategoriesLoading) {
            return GestureDetector(
                onTap: () =>
                    context.read<LoadCategoriesBloc>().add(LoadCategories()),
                child: TextField(
                  keyboardType: TextInputType.none,
                  canRequestFocus: false,
                  decoration: InputDecoration(
                      hintText: hintText,
                      fillColor: AppColor.lightGrey,
                      hintStyle: TextStyle(color: AppColor.blackText),
                      suffixIcon: CupertinoActivityIndicator(),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none)),
                ));
          } else if (state is CategoriesLoaded) {
            String? initialValue = controller.text.isNotEmpty
                ? controller.text
                : state.categories.isNotEmpty
                    ? state.categories[0].specificationID.toString()
                    : null;
            controller.text = initialValue!;
            return DropdownButtonFormField<String>(
              value: initialValue,
              onChanged: (newValue) => controller.text = newValue!,
              style: TextStyle(color: AppColor.blackText),
              decoration: InputDecoration(
                hintText: hintText,
                fillColor: AppColor.lightGrey,
                hintStyle: TextStyle(color: AppColor.blackText),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              items: state.categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category.specificationID.toString(),
                  child: Text(category.specification.toString()),
                );
              }).toList(),
            );
          } else {
            return Column(
              children: [
                TextField(
                  keyboardType: TextInputType.none,
                  canRequestFocus: false,
                  decoration: InputDecoration(
                      hintText: hintText,
                      fillColor: AppColor.lightGrey,
                      hintStyle: TextStyle(color: AppColor.blackText),
                      suffixIcon: CupertinoActivityIndicator(),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none)),
                ),
                SizedBox(height: 10),
                TextButton(
                    onPressed: () => context
                        .read<LoadCategoriesBloc>()
                        .add(LoadCategories()),
                    child: Text('Retry'))
              ],
            );
          }
        },
      ),
    );
  }
}
