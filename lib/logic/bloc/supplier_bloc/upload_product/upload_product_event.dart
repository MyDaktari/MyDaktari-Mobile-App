part of 'upload_product_bloc.dart';

abstract class UploadProductEvent extends Equatable {
  const UploadProductEvent();

  @override
  List<Object> get props => [];
}

class UploadProduct extends UploadProductEvent {
  final String supplierId;
  final String productName;
  final String productDescription;
  final String productCategory;
  final String productPrice;
  final String productQuantity;
  final String productVariations;
  final String productTags;
  final String productHighlights;
  final String productSpecifications;

  final String shippingInfo;
  final List<File> imageFiles;

  const UploadProduct(
      {required this.supplierId,
      required this.productName,
      required this.productDescription,
      required this.productCategory,
      required this.productPrice,
      required this.productQuantity,
      required this.productVariations,
      required this.productTags,
      required this.productHighlights,
      required this.productSpecifications,
      required this.shippingInfo,
      required this.imageFiles});
  @override
  List<Object> get props => [
        supplierId,
        productName,
        productDescription,
        productCategory,
        productPrice,
        productQuantity,
        shippingInfo,
        productVariations,
        productTags,
        productHighlights,
        productSpecifications,
        imageFiles
      ];
}
