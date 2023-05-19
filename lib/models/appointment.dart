class AppointmentModel {
  String? startTime;
  String? date;
  String? description;
  String? appointmentStatus;
  String? conditions;
  String? name;
  String? imagePath;

  AppointmentModel(
      {this.startTime,
      this.date,
      this.description,
      this.appointmentStatus,
      this.conditions,
      this.name,
      this.imagePath});

  AppointmentModel.fromJson(Map<String, dynamic> json) {
    startTime = json['start_time'];
    date = json['date'];
    description = json['description'];
    appointmentStatus = json['appointmentStatus'];
    conditions = json['conditions'];
    name = json['name'];
    imagePath = json['imagePath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_time'] = this.startTime;
    data['date'] = this.date;
    data['description'] = this.description;
    data['appointmentStatus'] = this.appointmentStatus;
    data['conditions'] = this.conditions;
    data['name'] = this.name;
    data['imagePath'] = this.imagePath;
    return data;
  }
}
