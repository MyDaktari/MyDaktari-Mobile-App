// ignore_for_file: body_might_complete_normally_nullable

import '../../models/models.dart';

abstract class BaseDoctorRepository {
  Future<List<AppointmentModel>?> getDoctorAppointments(
      {required String doctorId}) async {}
  Future<String?> addDoctorCharges(
      {required String doctorId,
      required String phoneCallCost,
      required String videoCallCost,
      required String chatCost}) async {}
  Future<String?> editDoctorCharges({required String chargesId}) async {}
  Future<DoctorChargesModel?> getDoctorCharges(
      {required String doctorId}) async {}
  Future<List<PatientModel>?> getDoctorPatients(
      {required String doctorId}) async {}
  Future<String?> addDoctorAvailability(
      {required int doctorId,
      required int duration,
      required Map<String, List<Map<String, dynamic>>> data}) async {}
}
