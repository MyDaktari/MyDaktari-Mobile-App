class SymptomModel {
  String? bodyPart;
  List<Symptoms>? symptoms;

  SymptomModel({this.bodyPart, this.symptoms});

  SymptomModel.fromJson(Map<String, dynamic> json) {
    bodyPart = json['body_part'];
    if (json['symptoms'] != null) {
      symptoms = <Symptoms>[];
      json['symptoms'].forEach((v) {
        symptoms!.add(Symptoms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['body_part'] = bodyPart;
    if (symptoms != null) {
      data['symptoms'] = symptoms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Symptoms {
  String? symptom;
  String? description;

  Symptoms({this.symptom, this.description});

  Symptoms.fromJson(Map<String, dynamic> json) {
    symptom = json['symptom'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['symptom'] = symptom;
    data['description'] = description;
    return data;
  }
}
