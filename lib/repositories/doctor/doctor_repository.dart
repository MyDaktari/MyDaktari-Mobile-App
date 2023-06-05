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
    print('user:$userId');
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

//   }
//   {
//   "doctorID": 12,
//   "duration":20,//should be in minutes
//   "availability": {
//     "Monday": [
//       {
//         "start": "09:00",
//         "end": "12:00"
//       },
//       {
//         "start": "14:00",
//         "end": "17:00"
//       },
//        {
//         "start": "19:00",
//         "end": "20:00"
//       },
//       {
//         "start": "21:00",
//         "end": "23:00"
//       }
//     ],
//     "Tuesday": [
//       {
//         "start": "08:30",
//         "end": "13:00"
//       }
//     ],
//     "Wednesday": [
//       {
//         "start": "08:30",
//         "end": "13:00"
//       }
//     ],
//     "Thursday": [
//       {
//         "start": "09:00",
//         "end": "12:00"
//       },
//       {
//         "start": "14:00",
//         "end": "17:00"
//       }
//     ],"Friday": [
//       {
//         "start": "09:00",
//         "end": "12:00"
//       },
//       {
//         "start": "14:00",
//         "end": "17:00"
//       },
//        {
//         "start": "19:00",
//         "end": "20:00"
//       },
//       {
//         "start": "21:00",
//         "end": "23:00"
//       }
//     ],
//     "Saturday": [
//       {
//         "start": "09:00",
//         "end": "12:00"
//       },
//       {
//         "start": "14:00",
//         "end": "17:00"
//       },
//        {
//         "start": "19:00",
//         "end": "20:00"
//       },
//       {
//         "start": "21:00",
//         "end": "23:00"
//       }
//     ]
//   }
// }
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
          "duration": duration, //should be in minutes
          "availability": data,
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
  Future<String> addDoctorCharges(
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
}
