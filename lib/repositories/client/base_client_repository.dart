// ignore_for_file: body_might_complete_normally_nullable

import '../../models/doctor_profile_model.dart';

abstract class BaseClientRepository {
  Future<List<DoctorProfileModel>?> fetchDoctors() async {}
  Future<List<DoctorProfileModel>?> searchDoctors(String searchTerm) async {}
  Future<List<DoctorProfileModel>?> showDoctorsBySyptoms(
      String symptomsId) async {}
  Future<List<String>?> fetchDoctorAvailability(
      {required String doctorId, required DateTime date}) async {}
}
