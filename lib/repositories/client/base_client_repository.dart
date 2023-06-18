// ignore_for_file: body_might_complete_normally_nullable

import 'package:my_daktari/models/client_appointment.dart';

import '../../models/doctor_profile_model.dart';

abstract class BaseClientRepository {
  Future<List<DoctorProfileModel>?> fetchDoctors() async {}
  Future<List<DoctorProfileModel>?> searchDoctors(String searchTerm) async {}
  Future<List<DoctorProfileModel>?> showDoctorsBySyptoms(
      String symptomsId) async {}
  Future<List<String>?> fetchDoctorAvailability(
      {required String doctorId, required DateTime date}) async {}
  Future<String?> makePayment(
      {required String appointmentID,
      required String amount,
      required String phoneNumber}) async {}
  Future<List<ClientAppointment>?> fetchClientAppointments(
      {required String clientID}) async {}
  Future<Map<String, dynamic>?> addNewAppointment(
      {required DateTime date,
      required String time,
      required String userId,
      required String doctorId,
      required String symptomID,
      required String description,
      required String meetingOption}) async {}
}
