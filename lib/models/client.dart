class ClientModel {
  int? userID;
  String? name;
  String? email;
  String? address;
  String? dob;
  String? phone;
  String? gender;

  ClientModel(
      {this.userID,
      this.name,
      this.email,
      this.address,
      this.dob,
      this.phone,
      this.gender});

  ClientModel.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    name = json['name'];
    email = json['email'];
    address = json['address'];
    dob = json['dob'];
    phone = json['phone'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userID'] = this.userID;
    data['name'] = this.name;
    data['email'] = this.email;
    data['address'] = this.address;
    data['dob'] = this.dob;
    data['phone'] = this.phone;
    data['gender'] = this.gender;
    return data;
  }
}
