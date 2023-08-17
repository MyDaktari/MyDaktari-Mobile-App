part of 'upload_product_data_cubit.dart';

class UploadProductDataState extends Equatable {
  final List<File> imageFiles;
  UploadProductDataState({
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
      imageFiles: imageFiles ?? this.imageFiles,
    );
  }

  @override
  List<Object?> get props => [imageFiles];
}
