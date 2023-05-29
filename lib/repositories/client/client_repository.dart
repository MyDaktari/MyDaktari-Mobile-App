import 'dart:convert';

import '../../constants/urls.dart';
import '../../models/doctor_profile_model.dart';
import 'base_client_repository.dart';
import 'package:http/http.dart' as http;

class ClientRepository extends BaseClientRepository {
  @override
  Future<List<DoctorProfileModel>> fetchDoctors() async {
    final response = await http.get(Uri.parse(fetchDoctorsUrl));
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
    final response = await http.post(Uri.parse(searchDoctorsUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'searchTerm': searchTerm}));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> doctorData = jsonData['data'];
      List<DoctorProfileModel> doctors =
          doctorData.map((data) => DoctorProfileModel.fromJson(data)).toList();
      return doctors;
    } else if (response.statusCode == 404) {
      throw Exception('Doctor Not found!');
    } else {
      throw Exception('Failed to search doctors');
    }
  }
}
