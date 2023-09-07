import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../../models/blood_sugar.dart';
import 'base_blood_sugar_repository.dart';

class BloodSugarRepository extends BaseBloodSugarRepository {
  //load blood sugar record
  @override
  Future<List<BloodSugarModel>> getBloodRecord({required String userId}) async {
    List<BloodSugarModel> bloodRecords = List.empty();
    final response = await http.post(
      Uri.parse('https://mydoc.my-daktari.com/new_api/bloodSugarRecords.php'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'userID': userId}),
    );
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data']['data'] as List;
      bloodRecords =
          jsonData.map((record) => BloodSugarModel.fromJson(record)).toList();
      return bloodRecords;
    } else if (response.statusCode == 404) {
      return bloodRecords = List.empty();
    } else {
      throw Exception('Failed to get Blogs ${response.statusCode}');
    }
  }

  //add blood sugar record
  @override
  Future<String> addBloodRecord(
      {required String userId,
      required double glucoseLevel,
      required String date,
      required String time,
      required String timeBase}) async {
    final response = await http.post(
      Uri.parse('https://mydoc.my-daktari.com/new_api/addBloodSugar.php'),
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
