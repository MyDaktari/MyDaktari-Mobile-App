import '../../models/doctor_profile_model.dart';

abstract class BaseClientRepository {
  Future<List<DoctorProfileModel>?> fetchDoctors() async {}
  Future<List<DoctorProfileModel>?> searchDoctors(String searchTerm) async {}
}
