// ignore_for_file: body_might_complete_normally_nullable

import 'dart:io';

import '../../../models/category.dart';
import '../../../models/product.dart';
import '../../../models/supplier_order_model.dart';

abstract class BaseProductRepository {
  Future<String?> uploadproduct({
    required String supplierId,
    required String productName,
    required String productDescription,
    required String productCategory,
    required String productPrice,
    required String productQuantity,
    required String productVariations,
    required String productTags,
    required String productHidhlights,
    required String productSpecifications,
    required String shippingInfomation,
    required List<File> imageFiles,
  }) async {}

  Future<List<ProductModel>?> getSupplierProducts(
      {required String supplierId}) async {}
  Future<List<SupplierOrderModel>?> getSupplierOrders(
      {required String supplierId}) async {}
  Future<List<ProductModel>?> getProductCatalogue() async {}
  Future<List<CategoryModel>?> getProductCategories() async {}
}
