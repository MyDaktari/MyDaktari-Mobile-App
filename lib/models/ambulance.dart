class AmbulanceModel {
  String? ambulanceName;
  String? ambulanceLocation;
  String? ambulancePhone;
  String? ambulanceEmail;

  AmbulanceModel(
      {this.ambulanceName,
      this.ambulanceLocation,
      this.ambulancePhone,
      this.ambulanceEmail});

  AmbulanceModel.fromJson(Map<String, dynamic> json) {
    ambulanceName = json['ambulanceName'];
    ambulanceLocation = json['ambulanceLocation'];
    ambulancePhone = json['ambulancePhone'];
    ambulanceEmail = json['ambulanceEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ambulanceName'] = this.ambulanceName;
    data['ambulanceLocation'] = this.ambulanceLocation;
    data['ambulancePhone'] = this.ambulancePhone;
    data['ambulanceEmail'] = this.ambulanceEmail;
    return data;
  }
}
