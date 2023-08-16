part of 'upload_product_data_cubit.dart';

class UploadProductDataState extends Equatable {
  final String userId;
  final String productName;
  final String productDescription;
  final String productCategory;
  final String productPrice;
  final String productVariations;
  final String productTags;
  final String productHighlights;
  final String productSpecifications;
  final String ShippingDetails;
  final List<File> imageFiles;
  UploadProductDataState({
    required this.userId,
    required this.productName,
    required this.productDescription,
    required this.productCategory,
    required this.productPrice,
    required this.productVariations,
    required this.productTags,
    required this.productHighlights,
    required this.productSpecifications,
    required this.ShippingDetails,
    required this.imageFiles,
  });

  UploadProductDataState copyWith({
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
    List<File>? imageFiles,
    int? currentStep,
  }) {
    return UploadProductDataState(
      userId: userId ?? this.userId,
      productName: productName ?? this.productName,
      productDescription: productDescription ?? this.productDescription,
      productCategory: productCategory ?? this.productCategory,
      productPrice: productPrice ?? this.productPrice,
      productVariations: productVariations ?? this.productVariations,
      productTags: productTags ?? this.productTags,
      productHighlights: productHighlights ?? this.productHighlights,
      productSpecifications:
          productSpecifications ?? this.productSpecifications,
      ShippingDetails: ShippingDetails ?? this.ShippingDetails,
      imageFiles: imageFiles ?? this.imageFiles,
    );
  }

  @override
  List<Object?> get props => [
        userId,
        productName,
        productDescription,
        productCategory,
        productPrice,
        productVariations,
        productTags,
        productHighlights,
        productSpecifications,
        ShippingDetails,
        imageFiles,
      ];
}
