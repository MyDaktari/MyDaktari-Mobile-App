class SupplierModel {
  int? supplierID;
  String? supplierName;
  String? supplierCode;
  String? supplierPhone;
  String? supplierEmail;
  String? supplierCategory;
  String? supplierAddress;
  String? supplierBirthDate;
  String? supplierGender;

  SupplierModel(
      {this.supplierID,
      this.supplierName,
      this.supplierCode,
      this.supplierPhone,
      this.supplierEmail,
      this.supplierCategory,
      this.supplierAddress,
      this.supplierBirthDate,
      this.supplierGender});

  SupplierModel.fromJson(Map<String, dynamic> json) {
    supplierID = json['supplierID'];
    supplierName = json['supplierName'];
    supplierCode = json['supplierCode'];
    supplierPhone = json['supplierPhone'];
    supplierEmail = json['supplierEmail'];
    supplierCategory = json['supplierCategory'];
    supplierAddress = json['supplierAddress'];
    supplierBirthDate = json['supplierBirthDate'];
    supplierGender = json['supplierGender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['supplierID'] = this.supplierID;
    data['supplierName'] = this.supplierName;
    data['supplierCode'] = this.supplierCode;
    data['supplierPhone'] = this.supplierPhone;
    data['supplierEmail'] = this.supplierEmail;
    data['supplierCategory'] = this.supplierCategory;
    data['supplierAddress'] = this.supplierAddress;
    data['supplierBirthDate'] = this.supplierBirthDate;
    data['supplierGender'] = this.supplierGender;
    return data;
  }
}
