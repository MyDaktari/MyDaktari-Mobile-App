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

  void addImageFiles({required List<File> imageFiles}) {
    final updatedImageFiles = List<File>.from(state.imageFiles);
    for (File newImage in imageFiles)
      if (!updatedImageFiles.any((element) => element.path == newImage.path))
        updatedImageFiles.add(newImage);
    emit(state.copyWith(imageFiles: updatedImageFiles));
  }

  // void addImageFilesV2({required List<File> imageFiles}) {
  //   final Set<String> existingPaths =
  //       Set.from(state.imageFiles.map((file) => file.path));
  //   final newImageFiles =
  //       imageFiles.where((file) => !existingPaths.contains(file.path));
  //   emit(state.copyWith(imageFiles: [...state.imageFiles, ...newImageFiles]));
  // }

  void removeImageFile({required File imageFile}) {
    final updatedImageFiles =
        state.imageFiles.where((file) => file != imageFile).toList();
    emit(state.copyWith(imageFiles: updatedImageFiles));
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
