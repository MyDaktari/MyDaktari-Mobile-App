import 'dart:convert';

import '../../constants/urls.dart';
import '../../models/pharmacy.dart';
import 'base_pharmacy_repository.dart';
import 'package:http/http.dart' as http;

class PharmacyRepository extends BasePharmacyRepository {
  //get doctor appointments.
  @override
  Future<List<PharmacyModel>> getPharmacy() async {
    List<PharmacyModel> pharmacyList = List.empty();
    final response = await http.post(Uri.parse(pharmacyUrl),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data'] as List;
      pharmacyList =
          jsonData.map((blog) => PharmacyModel.fromJson(blog)).toList();
      return pharmacyList;
    } else if (response.statusCode == 404) {
      return pharmacyList = List.empty();
    } else {
      throw Exception('Failed to get pharmacy ${response.statusCode}');
    }
  }
}
