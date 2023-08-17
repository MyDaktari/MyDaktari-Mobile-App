class ProductModel {
  int? productID;
  String? productName;
  String? productsImages;
  String? productDescription;
  int? productPrice;
  int? productsQuantity;
  String? productVariations;
  String? productTags;
  String? productHighlights;
  String? productSpecifications;
  String? shippingInformation;

  ProductModel(
      {this.productID,
      this.productName,
      this.productsImages,
      this.productDescription,
      this.productPrice,
      this.productsQuantity,
      this.productVariations,
      this.productTags,
      this.productHighlights,
      this.productSpecifications,
      this.shippingInformation});

  ProductModel.fromJson(Map<String, dynamic> json) {
    productID = json['productID'];
    productName = json['productName'];
    productsImages = json['productsImages'];
    productDescription = json['productDescription'];
    productPrice = json['productPrice'];
    productsQuantity = json['productsAvailable'];
    productVariations = json['productVariations'];
    productTags = json['productTags'];
    productHighlights = json['productHighlights'];
    productSpecifications = json['productSpecifications'];
    shippingInformation = json['shippingInformation'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productID'] = this.productID;
    data['productName'] = this.productName;
    data['productsImages'] = this.productsImages;
    data['productDescription'] = this.productDescription;
    data['productPrice'] = this.productPrice;
    data['productsAvailable'] = this.productsQuantity;
    data['productVariations'] = this.productVariations;
    data['productTags'] = this.productTags;
    data['productHighlights'] = this.productHighlights;
    data['productSpecifications'] = this.productSpecifications;
    data['shippingInformation'] = this.shippingInformation;
    return data;
  }
}
