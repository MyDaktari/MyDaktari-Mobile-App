import 'package:flutter/material.dart';
import 'package:my_daktari/models/client.dart';

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
  UserType? userType;
  bool? loggedIn;
  dynamic user;

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

  void authenticate(UserType userType, user) {
    if (userType.name.contains('client')) {
      this.user = user as ClientModel;
    } else {}
    notifyListeners();
    loggedIn = true;
  }

  void signOut() {
    loggedIn = false;

    notifyListeners();
  }
}

enum Sex { male, female }

enum UserType { doctor, client }
