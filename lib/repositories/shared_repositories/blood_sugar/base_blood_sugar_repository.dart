// ignore_for_file: body_might_complete_normally_nullable

import '../../../models/blood_sugar.dart';

abstract class BaseBloodSugarRepository {
  Future<List<BloodSugarModel>?> getBloodRecord(
      {required String userId}) async {}
  Future<String?> addBloodRecord(
      {required String userId,
      required double glucoseLevel,
      required String date,
      required String time,
      required String timeBase}) async {}
}
