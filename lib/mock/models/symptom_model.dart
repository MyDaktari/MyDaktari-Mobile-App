class SymptomModel {
  String? title;
  List<Symptoms>? symptoms;

  SymptomModel({this.title, this.symptoms});

  SymptomModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    if (json['symptoms'] != null) {
      symptoms = <Symptoms>[];
      json['symptoms'].forEach((v) {
        symptoms!.add(Symptoms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
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
