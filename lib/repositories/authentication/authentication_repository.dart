import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../constants/urls.dart';
import '../../models/models.dart';
import './base_authentication_repository.dart';

class AuthenticationRepository extends BaseAuthenticationRepository {
  //client
  @override
  Future<ClientModel> loginClient(
      {required String username, required String password}) async {
    final response = await http.post(Uri.parse('$loginClientUrl'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': username, 'password': password}));

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      ClientModel client = ClientModel.fromJson(responseBody['user']);
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

    if (response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      ClientModel client = ClientModel.fromJson(responseBody['user']);
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

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      DoctorModel doctor = DoctorModel.fromJson(responseBody['doctor']);
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
          "lat": "",
          "lng": "",
        }));

    if (response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      DoctorModel doctor = DoctorModel.fromJson(responseBody['doctor']);
      return doctor;
    } else if (response.statusCode == 401 || response.statusCode == 404) {
      throw Exception('Incorrect username or password');
    } else if (response.statusCode == 409) {
      throw Exception('Email already exist');
    } else {
      throw Exception('Failed to login');
    }
  }
}
