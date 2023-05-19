import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/urls.dart';
import '../../models/models.dart';
import 'base_doctor_repository.dart';

class DoctorRepository extends BaseDoctorRepository {
  //get doctor appointments.
  @override
  Future<List<AppointmentModel>> getDoctorAppointments(
      {required String doctorId}) async {
    List<AppointmentModel> appointments = List.empty();
    final response = await http.post(Uri.parse('$doctorAppointmentsUrl'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'doctorId': doctorId}));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data'] as List;
      appointments = jsonData
          .map((appointment) => AppointmentModel.fromJson(appointment))
          .toList();
      return appointments;
    } else if (response.statusCode == 404) {
      return appointments = List.empty();
    } else {
      print(response.statusCode);
      throw Exception('Failed to login');
    }
  }
}
