import 'dart:convert';

import 'package:intl/intl.dart';
import 'package:my_daktari/models/client_appointment.dart';

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
        body: json.encode(
            {'doctorID': 29, 'date': DateFormat('yyyy-MM-dd').format(date)}));
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

  Future<List<ClientAppointment>> fetchClientAppointments(
      {required String clientID}) async {
    final apiUrl = 'https://mydoc.my-daktari.com/new_api/patientDetails.php';

    final response = await http.post(Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({"userid": clientID}));
    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<dynamic> appointments = jsonData['data']['appointments'];
      List<ClientAppointment> clientAppointments =
          appointments.map((data) => ClientAppointment.fromJson(data)).toList();
      return clientAppointments;
    } else if (response.statusCode == 404) {
      throw Exception('No Appointment found');
    } else {
      throw Exception('Failed to fetch your appointments');
    }
  }

  @override
  Future<Map<String, dynamic>> addNewAppointment(
      {required DateTime date,
      required String time,
      required String userId,
      required String doctorId,
      required String symptomID,
      required String description,
      required String meetingOption}) async {
    final response = await http.post(
        Uri.parse("https://mydoc.my-daktari.com/new_api/addAppointment.php"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "userID": userId,
          "doctorID": doctorId,
          "startTime": convertTo24HourFormat(time),
          "symptomID": symptomID,
          "description": description,
          "date": DateFormat('yyyy-MM-dd').format(date),
          "meetingOption": meetingOption,
        }));

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      return {'appointmentID': data['appointmentID'], 'amount': data['amount']};
    } else {
      throw Exception('Failed to make your request');
    }
  }

  @override
  Future<String> makePayment(
      {required String appointmentID,
      required String amount,
      required String phoneNumber}) async {
    final response = await http.post(
        Uri.parse("https://mydoc.my-daktari.com/new_api/lipanampesa.php"),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          "appointmentID": appointmentID
              .trim(), //found from the create appointment request response
          "amount": int.parse(amount.trim()),
          "phoneNumber": phoneNumber
              .trim()
              .replaceFirst(phoneNumber.trim()[0], '254') // must start with 254
        }));

    if (response.statusCode == 200) {
      //  final data = json.decode(response.body);
      return 'We have sent a secure M-Pesa payment request to the provided number. Please enter your PIN to finalize your booking.';
    } else {
      throw Exception('Failed to make your request, try again');
    }
  }

  String convertToAmPm(String time) {
    final parsedTime = DateFormat('HH:mm').parse(time);
    return DateFormat('h:mm a').format(parsedTime);
  }

  String convertTo24HourFormat(String time) {
    final parsedTime = DateFormat('h:mm a').parse(time);
    return DateFormat('HH:mm').format(parsedTime);
  }
}
