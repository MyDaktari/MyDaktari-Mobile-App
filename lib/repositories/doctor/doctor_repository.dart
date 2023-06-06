import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_daktari/constants/constants.dart';

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
      print(response.statusCode);
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
    // print(extractJsonFromWarning(response.body));
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
        body: jsonEncode({"doctorId": doctorId}));
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

  //funtion to update the infomation about the doctor to complete the profile
  // @override
  // Future<DoctorProfileModel> completeDoctorProfile({
  //   required String specialty,
  //   required String careerOverview,
  //   required String location,
  //   required int experience,
  //   required PlatformFile profilePicture,
  //   required PlatformFile nationalId,
  // }) async {
    // var request = http.MultipartRequest('POST',
    //     Uri.parse('https://hub.blinkhub.co.ke/endpoints/api_add_supplier.php'));
    // Map<String, dynamic> jsonData = {
    //   "supplier_name": name,
    //   "product_name": productName,
    //   "supplier_email": email,
    //   "user_id": currentUser.userId,
    //   "supplier_type": supplierType.name.toString().trim(),
    // };
    // final file = platformFileToFile(platformFile);
    // // Add file to the request
    // var fileStream = http.ByteStream(Stream.castFrom(file.openRead()));
    // var fileSize = await file.length();
    // var mimeType = lookupMimeType(file.path);
    // var fileUpload = http.MultipartFile(
    //     'supplier_document', fileStream, fileSize,
    //     filename: file.path, contentType: MediaType.parse(mimeType.toString()));
    // request.files.add(fileUpload);

    //   // Add JSON data to the request
    //   request.fields['data'] = jsonEncode(jsonData);
    //   var response = await request.send();
    //   if (response.statusCode == 201) {
    //     return 'File and data uploaded successfully';
    //   } else {
    //     String error = await response.stream.bytesToString();
    //     String errorDecoded = jsonDecode(error)['message'].toString();
    //     throw (errorDecoded);
    //   }
    // }
  }

// //function to convert the file type from platformFile to File
// File platformFileToFile(PlatformFile platformFile) {
//   final filePath = platformFile.path;
//   // final fileName = path.basename(filePath.toString());
//   final file = File(filePath.toString());
//   return file;
// }
