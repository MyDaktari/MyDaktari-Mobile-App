class ProductModel {
  int? productID;
  String? productName;
  int? productPrice;
  List<String>? productsImages;
  String? productDescription;
  int? productsAvailable;
  String? productVariations;
  String? productTags;
  String? productHighlights;
  String? productSpecifications;
  String? shippingInformation;

  ProductModel(
      {this.productID,
      this.productName,
      this.productPrice,
      this.productsImages,
      this.productDescription,
      this.productsAvailable,
      this.productVariations,
      this.productTags,
      this.productHighlights,
      this.productSpecifications,
      this.shippingInformation});

  ProductModel.fromJson(Map<String, dynamic> json) {
    productID = json['productID'];
    productName = json['productName'];
    productPrice = json['productPrice'];
    productsImages = json['productsImages'].cast<String>();
    productDescription = json['productDescription'];
    productsAvailable = json['productsAvailable'];
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
    data['productPrice'] = this.productPrice;
    data['productsImages'] = this.productsImages;
    data['productDescription'] = this.productDescription;
    data['productsAvailable'] = this.productsAvailable;
    data['productVariations'] = this.productVariations;
    data['productTags'] = this.productTags;
    data['productHighlights'] = this.productHighlights;
    data['productSpecifications'] = this.productSpecifications;
    data['shippingInformation'] = this.shippingInformation;
    return data;
  }
}
