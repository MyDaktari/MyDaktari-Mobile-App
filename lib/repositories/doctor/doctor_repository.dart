import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:my_daktari/constants/constants.dart';
import 'package:http_parser/http_parser.dart';
import '../../constants/urls.dart';
import '../../models/models.dart';
import 'base_doctor_repository.dart';

class DoctorRepository extends BaseDoctorRepository {
  //get doctor appointments.
  @override
  Future<List<AppointmentModel>> getDoctorAppointments(
      {required String doctorId}) async {
    List<AppointmentModel> appointments = List.empty();
    final response = await http.post(
      Uri.parse(doctorAppointmentsUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"doctorID": userId}),
    );

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data'] as List;
      appointments = jsonData
          .map((appointment) => AppointmentModel.fromJson(appointment))
          .toList();
      return appointments;
    } else if (response.statusCode == 404 || response.statusCode == 400) {
      print('Empty appointments ${response.statusCode}');
      return appointments = List.empty();
    } else {
      throw Exception(
          'Failed to load your Appointments ${response.statusCode}');
    }
  }

  //get doctor patients.
  @override
  Future<List<PatientModel>> getDoctorPatients(
      {required String doctorId}) async {
    print('doctor: ## $doctorId');
    List<PatientModel> patients = List.empty();
    final response = await http.post(Uri.parse(getDoctorPatientsUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"doctorID": doctorId}));
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

  String extractJsonFromWarning(String warningMessage) {
    final regex = RegExp(r'{.*}');
    final match = regex.firstMatch(warningMessage);
    if (match != null) {
      final jsonStr = match.group(0);
      return jsonStr ?? '';
    }
    return '';
  }

  //add charges.
  @override
  Future<String> addDoctorAvailability(
      {required int doctorId,
      required int duration,
      required Map<String, List<Map<String, dynamic>>> data}) async {
    final response = await http.post(Uri.parse(addDoctorAvailabilityUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "doctorID": doctorId,
          "duration": duration,
          "availability": data
        }));
    final formattedData = jsonDecode(response.body);
    if (response.statusCode == 200) {
      final jsonData = formattedData['message'] as String;
      final message = jsonData;
      return message;
    } else {
      // Error occurred while setting availability
      throw Exception(formattedData["message"]);
    }
  }

  //add charges.
  @override
  Future<DoctorChargesModel> addDoctorCharges(
      {required String doctorId,
      required String phoneCallCost,
      required String videoCallCost,
      required String chatCost}) async {
    final response = await http.post(Uri.parse(addDoctorChargesUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "doctorID": doctorId,
          "phoneCall": phoneCallCost,
          "videoCall": videoCallCost,
          "chat": chatCost
        }));
    if (response.statusCode == 201) {
      final jsonData = jsonDecode(response.body);
      DoctorChargesModel charges =
          DoctorChargesModel.fromJson(jsonData['data']);
      return charges;
    } else if (response.statusCode == 400 || response.statusCode == 409) {
      throw Exception('You already have these charges');
    } else {
      throw Exception('Failed to record new charges ${response.statusCode}');
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
      throw Exception('Failed to edit the record ${response.statusCode}');
    }
  }

  //get doctor charges.
  @override
  Future<DoctorChargesModel> getDoctorCharges(
      {required String doctorId}) async {
    final response = await http.post(Uri.parse(getDoctorChargesUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"doctorId": doctorId}));
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data'];
      final doctorcharges = DoctorChargesModel.fromJson(jsonData);
      return doctorcharges;
    } else if (response.statusCode == 404) {
      throw Exception('No Charges found');
    } else {
      throw Exception('Failed to load your charges ${response.statusCode}');
    }
  }

  Future<String?> bookAppointment({
    required String userID,
    required String doctorID,
    required String startTime,
    required String endTime,
    required String symptomID,
    required String description,
    required String date,
    required String meetingOption,
  }) async {
    final apiUrl = bookAppointmentUrl;

    final response = await http.post(Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'userID': userID,
          'doctorID': doctorID,
          'startTime': startTime,
          'endTime': endTime,
          'symptomID': symptomID,
          'description': description,
          'date': date,
          'meetingOption': meetingOption
        }));
    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      return data['message'];
    } else {
      throw Exception('Failed to book your appointment');
    }
  }

  // funtion to update the infomation about the doctor to complete the profile
  @override
  Future<DoctorProfileModel> completeDoctorProfile({
    required String doctorId,
    required String title,
    required String specialty,
    required String careerOverview,
    required String location,
    required int experience,
    required PlatformFile profilePicture,
    required PlatformFile nationalId,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://mydoc.my-daktari.com/new_api/updateDoctorProfile.php'),
    );

    final profileFile = platformFileToFile(profilePicture);
    final natIdFile = platformFileToFile(nationalId);

    // Add files to the request
    request.files.add(
      http.MultipartFile(
        'nationalID',
        profileFile.readAsBytes().asStream(),
        profileFile.lengthSync(),
        filename: profileFile.path.split('/').last,
        contentType: MediaType('image', 'jpeg'),
      ),
    );
    request.files.add(
      http.MultipartFile(
        'certificates',
        natIdFile.readAsBytes().asStream(),
        natIdFile.lengthSync(),
        filename: natIdFile.path.split('/').last,
        contentType: MediaType('image', 'jpeg'),
      ),
    );

    // Add form data fields
    request.fields['doctorID'] = doctorId;
    request.fields['title'] = title;
    request.fields['overview'] = careerOverview;
    request.fields['location'] = location;
    request.fields['speciality'] = specialty;
    request.fields['experience'] = experience.toString();

    var response = await request.send();
    var message = await response.stream.bytesToString();
    print(message);
    if (response.statusCode == 200) {
      //final jsonData = jsonDecode(response.stream.bytesToString())['data'];
      // final doctor = DoctorProfileModel.fromJson(jsonData);

      return DoctorProfileModel();
    } else {
      String error = message;
      String errorDecoded = jsonDecode(error)['message'].toString();
      throw (errorDecoded);
    }
  }

//function to convert the file type from platformFile to File
  File platformFileToFile(PlatformFile platformFile) {
    final filePath = platformFile.path;
    // final fileName = path.basename(filePath.toString());
    final file = File(filePath.toString());
    return file;
  }
}
