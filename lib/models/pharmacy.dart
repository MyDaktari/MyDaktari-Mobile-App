class PharmacyModel {
  String? pharmacyName;
  String? pharmacyLocation;
  String? pharmacyPhone;
  String? pharmacyEmail;

  PharmacyModel(
      {this.pharmacyName,
      this.pharmacyLocation,
      this.pharmacyPhone,
      this.pharmacyEmail});

  PharmacyModel.fromJson(Map<String, dynamic> json) {
    pharmacyName = json['pharmacyName'];
    pharmacyLocation = json['pharmacyLocation'];
    pharmacyPhone = json['pharmacyPhone'];
    pharmacyEmail = json['pharmacyEmail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['pharmacyName'] = this.pharmacyName;
    data['pharmacyLocation'] = this.pharmacyLocation;
    data['pharmacyPhone'] = this.pharmacyPhone;
    data['pharmacyEmail'] = this.pharmacyEmail;
    return data;
  }
}
