import 'dart:convert';

import 'package:intl/intl.dart';

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

  @override
  Future<List<DoctorProfileModel>> showDoctorsBySyptoms(
      String symptomsId) async {
    final response = await http.post(Uri.parse(showDoctorsBySymptomsUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"symptomID": symptomsId}));
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

  @override
  Future<List<String>> fetchDoctorAvailability(
      {required String doctorId, required DateTime date}) async {
    final apiUrl = getDoctorAvailabilityUrl;

    final response = await http.post(Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'doctorID': doctorId,
          'date': DateFormat('yyyy-MM-dd').format(date)
        }));

    print(response.body);
    print(DateFormat('yyyy-MM-dd').format(date));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<String> timeSlots = List<String>.from(data['data']);
      final formattedTimeSlots = timeSlots.map((time) {
        return convertToAmPm(time);
      }).toList();

      return formattedTimeSlots;
    } else if (response.statusCode == 404) {
      throw Exception('Doctor not available on the selected date');
    } else {
      throw Exception('Failed to fetch doctor availability');
    }
  }

  String convertToAmPm(String time) {
    final parsedTime = DateFormat('HH:mm').parse(time);
    return DateFormat('h:mm a').format(parsedTime);
  }
}