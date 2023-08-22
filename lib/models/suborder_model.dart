class SubOrdersModel {
  String? productId;
  String? quantity;
  String? price;

  SubOrdersModel(
      {required this.productId, required this.quantity, required this.price});

  SubOrdersModel.fromJson(Map<String, dynamic> json) {
    productId = json['productID'];
    quantity = json['quantity'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['productID'] = productId;
    data['quantity'] = quantity;
    data['price'] = price;

    return data;
  }

  Map<String, dynamic> toMapWithSelectedFields() {
    return {
      "productID": productId,
      "quantity": quantity,
      "price": price,
    };
  }
}
