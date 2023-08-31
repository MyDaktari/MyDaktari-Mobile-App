// ignore_for_file: body_might_complete_normally_nullable

import '../../../models/medication.dart';

abstract class BaseMedicationRepository {
  Future<List<MedicationModel>?> getMedicationRecord(
      {required String userId}) async {}
  Future<String?> addMedicationRecord(
      {required String userId,
      required double glucoseLevel,
      required String date,
      required String time,
      required String timeBase}) async {}
}
