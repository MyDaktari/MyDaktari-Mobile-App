class SupplierModel {
  String? name;
  int? id;
  String? email;
  String? phone;
  String? dob;
  String? gender;
  String? profileImage;

  SupplierModel(
      {this.name,
      this.id,
      this.email,
      this.phone,
      this.dob,
      this.gender,
      this.profileImage});

  SupplierModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    dob = json['dob'];
    gender = json['gender'];
    profileImage = json['profileImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['profileImage'] = this.profileImage;
    return data;
  }
}
