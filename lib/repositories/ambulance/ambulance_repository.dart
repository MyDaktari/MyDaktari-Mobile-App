import 'dart:convert';

import '../../constants/urls.dart';
import '../../models/ambulance.dart';
import 'base_ambulance_repository.dart';
import 'package:http/http.dart' as http;

class AmbulanceRepository extends BaseAmbulanceRepository {
  //get doctor appointments.
  @override
  Future<List<AmbulanceModel>> getAmbulances() async {
    List<AmbulanceModel> ambulances = List.empty();
    final response = await http.post(Uri.parse(ambulanceUrl),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data'] as List;
      ambulances =
          jsonData.map((blog) => AmbulanceModel.fromJson(blog)).toList();
      return ambulances;
    } else if (response.statusCode == 404) {
      return ambulances = List.empty();
    } else {
      print(response.statusCode);
      throw Exception('Failed to login');
    }
  }
}
