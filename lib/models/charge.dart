class DoctorChargesModel {
  String? chargesId;
  String? doctorId;
  String? phoneCall;
  String? videoCall;
  String? chat;

  DoctorChargesModel(
      {this.chargesId,
      this.doctorId,
      this.phoneCall,
      this.videoCall,
      this.chat});

  DoctorChargesModel.fromJson(Map<String, dynamic> json) {
    doctorId = json['doctorID'];
    phoneCall = json['phoneCall'];
    videoCall = json['videoCall'];
    chat = json['chat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['doctorID'] = this.doctorId;
    data['phoneCall'] = this.phoneCall;
    data['videoCall'] = this.videoCall;
    data['chat'] = this.chat;
    return data;
  }
}
