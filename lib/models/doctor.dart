class DoctorModel {
  String? name;

  int? id;
  String? email;
  String? phone;
  String? dob;
  String? gender;
  String? speciality;
  String? description;
  String? location;
  String? lat;
  String? lng;

  DoctorModel(
      {this.name,
      this.id,
      this.email,
      this.phone,
      this.dob,
      this.gender,
      this.speciality,
      this.description,
      this.location,
      this.lat,
      this.lng});

  DoctorModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['userID'];
    email = json['email'];
    phone = json['phone'];
    dob = json['dob'];
    gender = json['gender'];
    speciality = json['speciality'];
    description = json['description'];
    location = json['location'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['userID'] = this.id;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['speciality'] = this.speciality;
    data['description'] = this.description;
    data['location'] = this.location;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}
