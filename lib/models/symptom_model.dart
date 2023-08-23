class SymptomModel {
  String? bodyPart;
  List<Symptoms>? symptoms;

  SymptomModel({this.bodyPart, this.symptoms});

  SymptomModel.fromJson(Map<String, dynamic> json) {
    bodyPart = json['bodyPart'];
    if (json['symptoms'] != null) {
      symptoms = <Symptoms>[];
      json['symptoms'].forEach((v) {
        symptoms!.add(Symptoms.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bodyPart'] = bodyPart;
    if (symptoms != null) {
      data['symptoms'] = symptoms!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Symptoms {
  int? symptomID;
  String? conditions;
  String? symptomsDescription;
  String? generalSpeciality;

  Symptoms(
      {this.symptomID,
      this.conditions,
      this.symptomsDescription,
      this.generalSpeciality});

  Symptoms.fromJson(Map<String, dynamic> json) {
    symptomID = json['symptomID'];
    conditions = json['conditions'];
    symptomsDescription = json['symptomsDescription'];
    generalSpeciality = json['generalSpeciality'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['symptomID'] = this.symptomID;
    data['conditions'] = this.conditions;
    data['symptomsDescription'] = this.symptomsDescription;
    data['generalSpeciality'] = this.generalSpeciality;
    return data;
  }
}
