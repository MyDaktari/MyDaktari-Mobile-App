import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../constants/urls.dart';
import '../../models/client.dart';
import './base_authentication_repository.dart';

class AuthenticationRepository extends BaseAuthenticationRepository {
  @override
  Future<ClientModel> login(
      {required String username, required String password}) async {
    final response = await http.post(
      Uri.parse('$loginClientUrl'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': username, 'password': password}),
    );

    if (response.statusCode == 200) {
      final responseBody = jsonDecode(response.body);

      ClientModel client = ClientModel.fromJson(responseBody['user']);
      return client;
    } else if (response.statusCode == 401 || response.statusCode == 404) {
      print('incorrect');
      throw Exception('Incorrect username or password');
    } else {
      print(response.statusCode);
      print('incorrect2');
      throw Exception('Failed to login');
    }
  }

  @override
  Future<ClientModel> RegisterDoctor({
    required String name,
    required String password,
    required String phone,
    required String dob,
    required String gender,
    required String email,
    required String description,
  }) async {
    final response = await http.post(
      Uri.parse('$registerDoctorUrl'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "name": name,
        "email": email,
        "phone": phone,
        "dob": dob,
        "gender": gender,
        "password": password,
        "description": description,
      }),
    );

    if (response.statusCode == 201) {
      final responseBody = jsonDecode(response.body);
      ClientModel client = ClientModel.fromJson(responseBody['user']);
      return client;
    } else if (response.statusCode == 401 || response.statusCode == 404) {
      print('incorrect');
      throw Exception('Incorrect username or password');
    } else {
      print(response.statusCode);
      print('incorrect2');
      throw Exception('Failed to login');
    }
  }
}
