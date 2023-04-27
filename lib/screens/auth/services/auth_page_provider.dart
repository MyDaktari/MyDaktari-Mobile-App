import 'package:flutter/material.dart';

class AuthPageProvider with ChangeNotifier {
  AuthPageProvider.instance() {
    setRegister(true);
    updateTerms(false);
    updateBirthDate(DateTime.now());
  }

  late bool isRegister;
  late bool termsAccepted;
  late DateTime birthDate;
  Sex? sex;

  void setRegister(bool isRegister) {
    this.isRegister = isRegister;
    notifyListeners();
  }

  void updateTerms(bool termsAccepted) {
    this.termsAccepted = termsAccepted;
    notifyListeners();
  }

  void updateBirthDate(DateTime birthDate) {
    this.birthDate = birthDate;
    notifyListeners();
  }

  void updateSex(Sex sex) {
    this.sex = sex;
    notifyListeners();
  }
}

enum Sex { male, female }
