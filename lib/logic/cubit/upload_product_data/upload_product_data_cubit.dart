import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'upload_product_data_state.dart';

class UploadProductDataCubit extends Cubit<UploadProductDataState> {
  UploadProductDataCubit()
      : super(UploadProductDataState(
          userId: '',
          productName: '',
          productDescription: '',
          productCategory: '',
          productPrice: '',
          productVariations: '',
          productTags: '',
          productHighlights: '',
          productSpecifications: '',
          ShippingDetails: '',
          imageFiles: [],
        ));

  void updateImageFiles({required List<File> imageFiles}) {
    emit(state.copyWith(imageFiles: imageFiles));
  }

  void addImageFile({required File imageFile}) {
    final List<File> imageFiles = List.from(state.imageFiles)..add(imageFile);
    emit(state.copyWith(imageFiles: imageFiles));
  }

  void removeImageFile({required File imageFile}) {
    final List<File> imageFiles = List.from(state.imageFiles)
      ..remove(imageFile);
    emit(state.copyWith(imageFiles: imageFiles));
  }

  void updateProductdata({
    String? userId,
    String? productName,
    String? productDescription,
    String? productCategory,
    String? productPrice,
    String? productVariations,
    String? productTags,
    String? productHighlights,
    String? productSpecifications,
    String? ShippingDetails,
  }) {
    emit(state.copyWith(
      userId: userId ?? state.userId,
      productName: productName ?? state.productName,
      productDescription: productDescription ?? state.productDescription,
      productCategory: productCategory ?? state.productCategory,
      productPrice: productPrice ?? state.productPrice,
      productVariations: productVariations ?? state.productVariations,
      productTags: productTags ?? state.productTags,
      productHighlights: productHighlights ?? state.productHighlights,
      productSpecifications:
          productSpecifications ?? state.productSpecifications,
      ShippingDetails: ShippingDetails ?? state.ShippingDetails,
    ));
  }
}
