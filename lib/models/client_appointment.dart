class ClientAppointment {
  int? appointmentID;
  String? appointmentIDMpesa;
  String? startTime;
  String? date;
  String? meetingOption;
  String? appointmentStatus;
  String? paymentStatus;
  String? amount;
  int? doctorID;
  String? doctorsName;
  String? doctorsSpecialty;

  ClientAppointment(
      {this.appointmentID,
      this.appointmentIDMpesa,
      this.startTime,
      this.date,
      this.meetingOption,
      this.appointmentStatus,
      this.paymentStatus,
      this.amount,
      this.doctorID,
      this.doctorsName,
      this.doctorsSpecialty});

  ClientAppointment.fromJson(Map<String, dynamic> json) {
    appointmentID = json['appointmentID'];
    appointmentIDMpesa = json['appointmentIDMpesa'];
    startTime = json['start_time'];
    date = json['date'];
    meetingOption = json['meetingOption'];
    appointmentStatus = json['appointmentStatus'];
    paymentStatus = json['paymentStatus'];
    amount = json['amount'];
    doctorID = json['doctorID'];
    doctorsName = json['doctorsName'];
    doctorsSpecialty = json['doctorsSpecialty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['appointmentID'] = this.appointmentID;
    data['appointmentIDMpesa'] = this.appointmentIDMpesa;
    data['start_time'] = this.startTime;
    data['date'] = this.date;
    data['meetingOption'] = this.meetingOption;
    data['appointmentStatus'] = this.appointmentStatus;
    data['paymentStatus'] = this.paymentStatus;
    data['amount'] = this.amount;
    data['doctorID'] = this.doctorID;
    data['doctorsName'] = this.doctorsName;
    data['doctorsSpecialty'] = this.doctorsSpecialty;
    return data;
  }
}
