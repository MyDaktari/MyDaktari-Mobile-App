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
    final response = await http.post(Uri.parse(doctorAppointmentsUrl),
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
      throw Exception('Failed to load your Appointments');
    }
  }

  //get doctor patients.
  @override
  Future<List<PatientModel>> getDoctorPatients(
      {required String doctorId}) async {
    List<PatientModel> patients = List.empty();
    final response = await http.post(Uri.parse(getDoctorPatientsUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'doctorId': doctorId}));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data'] as List;
      patients =
          jsonData.map((patient) => PatientModel.fromJson(patient)).toList();
      return patients;
    } else if (response.statusCode == 404) {
      return patients = List.empty();
    } else {
      print(response.statusCode);
      throw Exception('Failed to load your Patients');
    }
  }

  //add charges.
  @override
  Future<String> addDoctorCharges({required DoctorChargesModel charges}) async {
    final response = await http.post(Uri.parse(addDoctorChargesUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "doctorID": charges.doctorId,
          "phoneCall": charges.phoneCall,
          "videoCall": charges.videoCall,
          "chat": charges.chat
        }));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['message'] as String;
      final message = jsonData;

      return message;
    } else if (response.statusCode == 400 || response.statusCode == 409) {
      throw Exception('You already have these charges');
    } else {
      print(response.statusCode);
      throw Exception('Failed to record new charges');
    }
  }
  //edit charges.

  @override
  Future<String> editDoctorCharges({required String chargesId}) async {
    final response = await http.post(Uri.parse(editDoctorChargesUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"chargeId": chargesId}));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['message'] as String;
      final message = jsonData;

      return message;
    } else if (response.statusCode == 400 || response.statusCode == 409) {
      throw Exception('Record Not found');
    } else {
      print(response.statusCode);
      throw Exception('Failed to edit the record');
    }
  }

  //get doctor charges.
  @override
  Future<DoctorChargesModel> getDoctorCharges(
      {required String doctorId}) async {
    final response = await http.post(Uri.parse(getDoctorChargesUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'doctorId': doctorId}));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data'];
      final doctorcharges = DoctorChargesModel.fromJson(jsonData);
      return doctorcharges;
    } else if (response.statusCode == 404) {
      throw Exception('No Charges found');
    } else {
      print(response.statusCode);
      throw Exception('Failed to load your charges');
    }
  }
}
