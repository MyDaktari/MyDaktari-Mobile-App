class CategoryModel {
  int? specificationID;
  String? specification;
  String? specificationDescription;

  CategoryModel(
      {this.specificationID,
      this.specification,
      this.specificationDescription});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    specificationID = json['specificationID'];
    specification = json['specification'];
    specificationDescription = json['specificationDescription'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['specificationID'] = this.specificationID;
    data['specification'] = this.specification;
    data['specificationDescription'] = this.specificationDescription;
    return data;
  }
}
