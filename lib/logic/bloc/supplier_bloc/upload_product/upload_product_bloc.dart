import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../repositories/supplier/product/product_repository.dart';

part 'upload_product_event.dart';
part 'upload_product_state.dart';

class UploadProductBloc extends Bloc<UploadProductEvent, UploadProductState> {
  final ProductRepository productRepository;
  UploadProductBloc({required ProductRepository repository})
      : productRepository = repository,
        super(UploadProductInitial()) {
    on<UploadProduct>(_onUploadProduct);
  }
  void _onUploadProduct(
      UploadProduct event, Emitter<UploadProductState> emit) async {
    emit(UploadProductLoading());
    try {
      String message = await productRepository.uploadproduct(
          supplierId: event.supplierId,
          productName: event.productName,
          productDescription: event.productDescription,
          productCategory: event.productCategory,
          productPrice: event.productPrice,
          productQuantity: event.productQuantity,
          productVariations: event.productVariations,
          productTags: event.productTags,
          productHidhlights: event.productHighlights,
          productSpecifications: event.productSpecifications,
          shippingInfomation: event.shippingInfo,
          imageFiles: event.imageFiles);
      emit(UploadProductSuccess(message: message));
    } catch (error) {
      emit(UploadProductFailed(message: error.toString()));
    }
  }
}
