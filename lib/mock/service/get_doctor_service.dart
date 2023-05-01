import 'package:flutter/material.dart';
import 'package:my_daktari/mock/models/doctor_model.dart';

import '../doctors/doctors.dart' as dkt;

class GetDoctor extends ChangeNotifier {
  List<DoctorModel> doctors = [];
  bool resultReturned = false;

  void search(String searchTerm) {
    List<DoctorModel> docs =
        dkt.doctors.map((json) => DoctorModel.fromJson(json)).toList();

    doctors = docs
        .where((doc) =>
            (doc.name?.toLowerCase().contains(searchTerm.toLowerCase()) ??
                false) ||
            (doc.title?.toLowerCase().contains(searchTerm.toLowerCase()) ??
                false) ||
            (doc.speciality?.toLowerCase().contains(searchTerm.toLowerCase()) ??
                false) ||
            (doc.institution
                    ?.toLowerCase()
                    .contains(searchTerm.toLowerCase()) ??
                false))
        .toList();
    resultReturned = true;
    notifyListeners();
  }

  void resetResultReturned() {
    doctors = [];
    resultReturned = false;
    notifyListeners();
  }
}
