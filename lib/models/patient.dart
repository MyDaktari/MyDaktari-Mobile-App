class PatientModel {
  String? name;
  String? imagePath;
  String? description;
  String? startTime;

  PatientModel({this.name, this.imagePath, this.description, this.startTime});

  PatientModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    imagePath = json['imagePath'];
    description = json['description'];
    startTime = json['start_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['imagePath'] = this.imagePath;
    data['description'] = this.description;
    data['start_time'] = this.startTime;
    return data;
  }
}
