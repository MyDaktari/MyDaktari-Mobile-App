class MedicationModel {
  String? dateTime;
  double? glucoseLevel;
  String? note;

  MedicationModel({this.dateTime, this.glucoseLevel, this.note});

  MedicationModel.fromJson(Map<String, dynamic> json) {
    dateTime = json['dateTime'];
    // Handle both int and double types for glucoseLevel
    if (json['glucoseLevel'] is int) {
      glucoseLevel = (json['glucoseLevel'] as int).toDouble();
    } else {
      glucoseLevel = json['glucoseLevel'];
    }
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
