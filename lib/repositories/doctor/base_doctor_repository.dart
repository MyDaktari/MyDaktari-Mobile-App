import '../../models/models.dart';

abstract class BaseDoctorRepository {
  Future<List<AppointmentModel>?> getDoctorAppointments(
      {required String doctorId}) async {}
}
