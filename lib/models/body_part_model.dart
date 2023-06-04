class BodyPartModel {
  String? bodyPart;

  BodyPartModel({this.bodyPart});

  BodyPartModel.fromJson(Map<String, dynamic> json) {
    bodyPart = json['bodyPart'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bodyPart'] = this.bodyPart;
    return data;
  }
}
