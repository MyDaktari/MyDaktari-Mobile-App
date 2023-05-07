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
  User? user;

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

  void authenticate(User user) {
    this.user = user;
    notifyListeners();
  }

  void signOut() {
    user = null;

    notifyListeners();
  }
}

enum Sex { male, female }

class User {
  final String name;
  final int age;
  final String email;
  final Sex sex;
  final String password;

  User(this.sex,
      {required this.password,
      required this.name,
      required this.age,
      required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      Sex.values.firstWhere((e) => e.toString() == 'Sex.${json['sex']}'),
      name: json['name'],
      age: json['age'],
      email: json['email'],
      password: json['password'],
    );
  }
}
