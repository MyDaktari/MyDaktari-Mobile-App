import 'dart:convert';

import 'package:my_daktari/models/body_part_model.dart';
import 'package:my_daktari/repositories/client/bodyparts/base_body_parts_repository.dart';
import 'package:http/http.dart' as http;

class BodyPartsRepository extends BaseBodyPartsRepository {
  @override
  Future<List<BodyPartModel>> getBodyParts() async {
    print('Fetching body parts');
    List<BodyPartModel> bodyParts = List.empty();
    final response = await http.post(
        Uri.parse('https://mydoc.my-daktari.com/new_api/bodyParts.php'),
        headers: {'Content-Type': 'application/json'});
    print(response.body);
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data'] as List;
      bodyParts =
          jsonData.map((bodypart) => BodyPartModel.fromJson(bodypart)).toList();
      return bodyParts;
    } else if (response.statusCode == 404) {
      return bodyParts = List.empty();
    } else {
      throw Exception('Failed to fetch body parts ${response.statusCode}');
    }
  }
}
