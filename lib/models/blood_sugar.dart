class BloodSugarModel {
  String? dateTime;
  double? glucoseLevel;
  String? note;

  BloodSugarModel({this.dateTime, this.glucoseLevel, this.note});

  BloodSugarModel.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    glucoseLevel = json['glucoseLevel'].toDouble(); // Always parse as double
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dateTime'] = this.dateTime;
    data['glucoseLevel'] = this.glucoseLevel;
    data['note'] = this.note;
    return data;
  }
}
