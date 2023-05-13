class Client {
  String? name;
  int? id;
  String? email;
  String? phone;
  String? dob;
  String? gender;

  Client({this.name, this.id, this.email, this.phone, this.dob, this.gender});

  Client.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    email = json['email'];
    phone = json['phone'];
    dob = json['dob'];
    gender = json['gender'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['id'] = this.id;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    return data;
  }
}
