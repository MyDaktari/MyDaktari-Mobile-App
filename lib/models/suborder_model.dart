class SubOrdersModel {
  String? id;
  String? userId;
  String? productId;
  String? orderId;
  String? quantity;
  String? totalPrice;
  String? dateCreated;
  String? productName;
  String? unitPrice;

  SubOrdersModel(
      {this.id,
      this.userId,
      this.productId,
      this.orderId,
      this.quantity,
      this.totalPrice,
      this.dateCreated,
      this.productName,
      this.unitPrice});

  SubOrdersModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    orderId = json['order_id'];
    quantity = json['quantity'];
    totalPrice = json['total_price'];
    dateCreated = json['date_created'];
    productName = json['product_name'];
    unitPrice = json['unit_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['product_id'] = productId;
    data['order_id'] = orderId;
    data['quantity'] = quantity;
    data['total_price'] = totalPrice;
    data['date_created'] = dateCreated;
    data['product_name'] = productName;
    data['unit_price'] = unitPrice;
    return data;
  }

  Map<String, dynamic> toMapWithSelectedFields() {
    return {
      "product_id": productId,
      "quantity": quantity,
      "total_price": totalPrice,
    };
  }
}
