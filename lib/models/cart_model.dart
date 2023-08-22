import 'package:equatable/equatable.dart';
import 'package:my_daktari/models/product.dart';

class CartModel extends Equatable {
  final List<ProductModel> products;
  const CartModel({this.products = const <ProductModel>[]});

//!the function mapping the cart products to debuplicate the product in cart screen
// prevent the same product to appear twice in the cart screen
/*
  The method productQuantity takes a product as an argument and returns a map of product to quantity, 
  where the quantity is the number of times the same product appears in the products list.
*/
  Map productQuantity(product) {
    var quantity = {};
    for (var product in products) {
      if (!quantity.containsKey(product)) {
        quantity[product] = 1;
      } else {
        quantity[product] += 1;
      }
    }
    return quantity;
  }

  double total(subtotal) {
    double shippingFee = 200;
    return subtotal + shippingFee;
  }

  int getProductQuantity(ProductModel product) {
    int count = 0;
    for (var item in products) {
      if (item == product) {
        count++;
      }
    }
    return count;
  }

  //returns the total price of the product items in the cart list as double
  double get subtotal => products.fold(
      0,
      (total, current) =>
          total + double.parse(current.productPrice.toString()));

  double get totalAmount => total(subtotal);
  double get shippingFee => 200;

  //returns the total price of the product items in the cart list as String
  String get subtotalString => subtotal.toStringAsFixed(2);
  String get totalAmountString => totalAmount.toStringAsFixed(2);
  @override
  List<Object?> get props => [products];
}
