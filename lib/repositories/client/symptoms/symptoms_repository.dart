import 'dart:convert';

import 'package:my_daktari/models/symptom_model.dart';
import 'package:http/http.dart' as http;

class SymptomsRepository {
  Future<List<SymptomModel>> getSymptoms(Map<String, dynamic> query) async {
    List<SymptomModel> symptoms = List.empty();
    final response = await http.post(
        Uri.parse('https://mydoc.my-daktari.com/new_api/reportSymptoms.php'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(query));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data'] as List;

      symptoms =
          jsonData.map((symptom) => SymptomModel.fromJson(symptom)).toList();
      return symptoms;
    } else if (response.statusCode == 404) {
      return symptoms = List.empty();
    } else {
      throw Exception('Failed to fetch symptoms ${response.statusCode}');
    }
  }
}
