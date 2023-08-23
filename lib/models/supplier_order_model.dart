class SupplierOrderModel {
  int? orderID;
  String? orderCode;
  String? totalAmount;
  String? orderDate;
  String? deliveryStatus;

  SupplierOrderModel(
      {this.orderID,
      this.orderCode,
      this.totalAmount,
      this.orderDate,
      this.deliveryStatus});

  SupplierOrderModel.fromJson(Map<String, dynamic> json) {
    orderID = json['orderID'];
    orderCode = json['orderCode'];
    totalAmount = json['totalAmount'];
    orderDate = json['orderDate'];
    deliveryStatus = json['deliveryStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['orderID'] = this.orderID;
    data['orderCode'] = this.orderCode;
    data['totalAmount'] = this.totalAmount;
    data['orderDate'] = this.orderDate;
    data['deliveryStatus'] = this.deliveryStatus;
    return data;
  }
}
