import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import '../../../models/category.dart';
import '../../../models/product.dart';
import 'base_product_repository.dart';

class ProductRepository extends BaseProductRepository {
  @override
  Future<String> uploadproduct({
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
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://mydoc.my-daktari.com/new_api/addProducts.php'),
    );

    // Add files to the request
    for (var imageFile in imageFiles) {
      request.files.add(http.MultipartFile('productImages[]',
          imageFile.readAsBytes().asStream(), imageFile.lengthSync(),
          filename: imageFile.path.split('/').last));
    }

    // Add form data fields
    request.fields['supplierID'] = supplierId;
    request.fields['productName'] = productName;
    request.fields['productDescription'] = productDescription;
    request.fields['productCategory'] = productCategory;
    request.fields['productPrice'] = productPrice;
    request.fields['productsAvailable'] = productQuantity;
    request.fields['productVariations'] = productVariations;
    request.fields['productTags'] = productTags;
    request.fields['productHighlights'] = productHidhlights;
    request.fields['productSpecifications'] = productSpecifications;
    request.fields['shippingInformation'] = shippingInfomation;
    var response = await request.send();
    var message = await response.stream.bytesToString();
    if (response.statusCode == 201) {
      String successMessageDecoded = jsonDecode(message)['message'].toString();
      return successMessageDecoded;
    } else {
      String errorDecoded = jsonDecode(message)['message'].toString();
      throw (errorDecoded);
    }
  }

  @override
  Future<List<ProductModel>> getSupplierProducts(
      {required String supplierId}) async {
    final response = await http.post(
        Uri.parse('https://mydoc.my-daktari.com/new_api/productCatalogue.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"supplierID": supplierId}));
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data']
          .map((json) => ProductModel.fromJson(json))
          .toList();
      List<ProductModel> products = data.cast<ProductModel>();
      return products;
    } else if (response.statusCode == 404) {
      throw Exception('Products not found');
    } else {
      throw Exception('Failed load your products');
    }
  }

  @override
  Future<List<ProductModel>> getProductCatalogue() async {
    final response = await http.post(
      Uri.parse('https://mydoc.my-daktari.com/new_api/shop.php'),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data']
          .map((json) => ProductModel.fromJson(json))
          .toList();
      List<ProductModel> products = data.cast<ProductModel>();
      return products;
    } else if (response.statusCode == 404) {
      throw Exception('Products not found');
    } else {
      throw Exception('Failed load products');
    }
  }

  @override
  Future<List<CategoryModel>> getProductCategories() async {
    final response = await http.post(
      Uri.parse(
          'https://mydoc.my-daktari.com/new_api/allSupplierCategories.php'),
      headers: {'Content-Type': 'application/json'},
    );
    print(response.body);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)['data']
          .map((json) => CategoryModel.fromJson(json))
          .toList();
      List<CategoryModel> products = data.cast<CategoryModel>();
      return products;
    } else if (response.statusCode == 404) {
      throw Exception('Categories not found');
    } else {
      throw Exception('Failed load products categories');
    }
  }
}
