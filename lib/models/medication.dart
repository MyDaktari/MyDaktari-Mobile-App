class MedicationModel {
  String? medicationName;
  String? dateTime;
  int? dosage;

  MedicationModel({this.medicationName, this.dateTime, this.dosage});

  MedicationModel.fromJson(Map<String, dynamic> json) {
    medicationName = json['medicationName'];
    dateTime = json['dateTime'];
    dosage = json['dosage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medicationName'] = this.medicationName;
    data['dateTime'] = this.dateTime;
    data['dosage'] = this.dosage;
    return data;
  }
}
