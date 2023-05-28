import 'dart:convert';

import '../../models/doctor_profile_model.dart';
import 'base_client_repository.dart';
import 'package:http/http.dart' as http;

class ClientRepository extends BaseClientRepository {
  @override
  Future<List<DoctorProfileModel>> fetchDoctors() async {
    final response = await http.get(Uri.parse('your_api_endpoint_here'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> doctorData = jsonData['data'];

      List<DoctorProfileModel> doctors =
          doctorData.map((data) => DoctorProfileModel.fromJson(data)).toList();
      return doctors;
    } else {
      throw Exception('Failed to fetch doctors');
    }
  }

  @override
  Future<List<DoctorProfileModel>> searchDoctors(String searchTerm) async {
    final response = await http.post(Uri.parse('your_search_api_endpoint_here'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'searchTerm': searchTerm}));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> doctorData = jsonData['data'];

      List<DoctorProfileModel> doctors =
          doctorData.map((data) => DoctorProfileModel.fromJson(data)).toList();
      return doctors;
    } else {
      throw Exception('Failed to search doctors');
    }
  }
}
import 'dart:convert';

import '../../models/doctor_profile_model.dart';
import 'base_client_repository.dart';
import 'package:http/http.dart' as http;

class ClientRepository extends BaseClientRepository {
  @override
  Future<List<DoctorProfileModel>> fetchDoctors() async {
    final response = await http
        .get(Uri.parse('https://mydoc.my-daktari.com/new_api/viewDoctors.php'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> doctorData = jsonData['data'];

      List<DoctorProfileModel> doctors =
          doctorData.map((data) => DoctorProfileModel.fromJson(data)).toList();
      return doctors;
    } else {
      throw Exception('Failed to fetch doctors');
    }
  }

  @override
  Future<List<DoctorProfileModel>> searchDoctors(String searchTerm) async {
    final response = await http.post(
        Uri.parse('https://mydoc.my-daktari.com/new_api/searchDoctor.php'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'searchTerm': searchTerm}));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> doctorData = jsonData['data'];

      List<DoctorProfileModel> doctors =
          doctorData.map((data) => DoctorProfileModel.fromJson(data)).toList();
      return doctors;
    } else {
      throw Exception('Failed to search doctors');
    }
  }
}
