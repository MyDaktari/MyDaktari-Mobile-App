import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/constants/enums.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/urls.dart';
import '../../models/models.dart';
import './base_authentication_repository.dart';

class AuthenticationRepository extends BaseAuthenticationRepository {
  //client
  @override
  Future<ClientModel> loginClient(
      {required String username, required String password}) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await http.post(Uri.parse('$loginClientUrl'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': username, 'password': password}));
    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      ClientModel client = ClientModel.fromJson(responseBody['user']);
      preferences.setString('user', jsonEncode(responseBody['user']));
      preferences.setString('userType', UserType.client.name);
      return client;
    } else if (response.statusCode == 401 ||
        response.statusCode == 404 ||
        response.statusCode == 400) {
      throw Exception('Incorrect username or password');
    } else {
      print(response.statusCode);
      throw Exception('Failed to login');
    }
  }

  @override
  Future<ClientModel> registerClient(
      {required String address,
      required String dob,
      required String email,
      required String gender,
      required String name,
      required String password,
      required String phone}) async {
    final response = await http.post(Uri.parse('$registerClientUrl'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": name,
          "email": email,
          "phone": phone,
          "dob": dob,
          "gender": gender,
          "password": password,
          "address": address,
          "lat": "",
          "lng": "",
        }));
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      ClientModel client = ClientModel.fromJson(responseBody['data']);
      preferences.setString('user', jsonEncode(responseBody['data']));
      preferences.setString('userType', UserType.client.name);
      userPhoneNumber = client.phone!;
      return client;
    } else if (response.statusCode == 401 || response.statusCode == 404) {
      throw Exception('Incorrect username or password');
    } else if (response.statusCode == 409) {
      throw Exception('Email already exist');
    } else {
      throw Exception('Failed to login');
    }
  }

  //doctor
  @override
  Future<DoctorModel> loginDoctor(
      {required String username, required String password}) async {
    final response = await http.post(Uri.parse('$loginDoctorUrl'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': username, 'password': password}));
    SharedPreferences preferences = await SharedPreferences.getInstance();

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      DoctorModel doctor = DoctorModel.fromJson(responseBody['doctor']);
      preferences.setString('user', jsonEncode(responseBody['doctor']));
      preferences.setString('userType', UserType.doctor.name);
      return doctor;
    } else if (response.statusCode == 401 ||
        response.statusCode == 404 ||
        response.statusCode == 400) {
      throw Exception('Incorrect username or password');
    } else {
      print(response.statusCode);
      throw Exception('Failed to login');
    }
  }

  @override
  Future<DoctorModel> registerDoctor({
    required String name,
    required String password,
    required String phone,
    required String dob,
    required String gender,
    required String email,
  }) async {
    final response = await http.post(Uri.parse('$registerDoctorUrl'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "name": name,
          "email": email,
          "phone": phone,
          "dob": dob,
          "gender": gender,
          "password": password,
          "lat": "37.7749",
          "lng": "-122.4194"
        }));

    SharedPreferences preferences = await SharedPreferences.getInstance();
    print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);
      DoctorModel doctor = DoctorModel.fromJson(responseBody['data']);
      preferences.setString('user', jsonEncode(responseBody['data']));
      preferences.setString('userType', UserType.doctor.name);
      userPhoneNumber = doctor.phone!;
      return doctor;
    } else if (response.statusCode == 401 || response.statusCode == 404) {
      throw Exception('Incorrect username or password');
    } else if (response.statusCode == 409) {
      throw Exception('Email already exist');
    } else {
      print(response.statusCode);
      throw Exception('Failed to login');
    }
  }

  //function to check the user Authentication status
  @override
  Future<Map<String, dynamic>> checkUser() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? userFromPrefs = preferences.getString('user');
    String? userTypeFromPrefs = preferences.getString('userType');
    dynamic user;

    if (userTypeFromPrefs != null) {
      if (userFromPrefs != null) {
        if (userTypeFromPrefs == UserType.client.name) {
          final userString = jsonDecode(userFromPrefs);
          ClientModel client = ClientModel.fromJson(userString);
          user = client;
        } else {
          final userString = jsonDecode(userFromPrefs);
          DoctorModel doctor = DoctorModel.fromJson(userString);
          user = doctor;
        }
      }
      return {
        'user': user,
        'userType': (userTypeFromPrefs == UserType.client.name)
            ? UserType.client
            : UserType.doctor,
      };
    } else {
      throw Exception('User Not Authenticated');
    }
  }

  @override
  Future<String> otpRequest({required String phoneNumber}) async {
    final response = await http.post(Uri.parse('$otpRequestUrl'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"phone": phoneNumber}));

    print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      String message = jsonDecode(response.body)['message'];
      return message;
    } else {
      print(response.statusCode);
      throw Exception('Fail to send OTP');
    }
  }

  @override
  Future<String> otpVerification(
      {required String phoneNumber, required String otp}) async {
    final response = await http.post(Uri.parse('$otpVerificationUrl'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"phone": phoneNumber, "otp": otp}));

    print(response.body);
    if (response.statusCode == 201 || response.statusCode == 200) {
      String message = jsonDecode(response.body)['message'];
      return message;
    } else {
      print(response.statusCode);
      throw Exception('Invalid OTP');
    }
  }

  @override
  Future<bool> logOut() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    bool deleteUseType = await preferences.remove('userType');
    bool logUerOut = await preferences.remove('user');
    return deleteUseType && logUerOut;
  }
}
