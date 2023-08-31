import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../../models/medication.dart';
import 'base_medication_repository.dart';

class MedicationRepository extends BaseMedicationRepository {
  //load blood sugar record
  @override
  Future<List<MedicationModel>> getMedicationRecord(
      {required String userId}) async {
    List<MedicationModel> medications = List.empty();
    final response = await http.post(
      Uri.parse('https://mydoc.my-daktari.com/new_api/MedicationRecords.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userID': userId}),
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data']['data'] as List;
      medications =
          jsonData.map((record) => MedicationModel.fromJson(record)).toList();

      return medications;
    } else if (response.statusCode == 404) {
      return medications = List.empty();
    } else {
      throw Exception('Failed to get Blogs ${response.statusCode}');
    }
  }

  //add blood sugar record
  @override
  Future<String> addMedicationRecord(
      {required String userId,
      required double glucoseLevel,
      required String date,
      required String time,
      required String timeBase}) async {
    final response = await http.post(
      Uri.parse('https://mydoc.my-daktari.com/new_api/addMedication.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'userID': userId,
        'glucoseLevel': glucoseLevel,
        'date': date,
        'time': time,
        'timeBase': timeBase,
      }),
    );
    print(response.body);
    if (response.statusCode == 201) {
      String message = jsonDecode(response.body)['message'];
      return message;
    } else {
      throw Exception('Failed to add blood sugar record!, Please try again');
    }
  }
}
