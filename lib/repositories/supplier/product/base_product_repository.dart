// ignore_for_file: body_might_complete_normally_nullable

import 'dart:io';

abstract class BaseProductRepository {
  Future<String?> uploadPrescription(
      {required String supplierId,
      required String productName,
      required String productDescription,
      required String productCategory,
      required String productPrice,
      required String productAvailable,
      required String productVariations,
      required String productTags,
      required String productHidhlights,
      required String productSpecifications,
      required String productInfomation,
      required List<File> imageFiles}) async {}
}
