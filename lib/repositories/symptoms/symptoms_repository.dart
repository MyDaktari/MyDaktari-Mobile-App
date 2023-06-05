import 'dart:convert';

import 'package:my_daktari/mock/models/symptom_model.dart';
import 'package:http/http.dart' as http;

class SymptomsRepository {
  Future<List<SymptomModel>> getSymptoms(Map<String, dynamic> query) async {
    List<SymptomModel> symptoms = List.empty();
    final response = await http.post(
        Uri.parse('https://mydoc.my-daktari.com/new_api/reportSymptoms.php'),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data'] as List;
      print(jsonData);
      symptoms =
          jsonData.map((symptom) => SymptomModel.fromJson(symptom)).toList();
      return symptoms;
    } else if (response.statusCode == 404) {
      return symptoms = List.empty();
    } else {
      print(response.statusCode);
      throw Exception('Failed to fetch symptoms');
    }
  }
}
