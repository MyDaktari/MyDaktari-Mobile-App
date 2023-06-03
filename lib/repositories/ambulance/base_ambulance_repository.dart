// ignore_for_file: body_might_complete_normally_nullable

import '../../models/ambulance.dart';

abstract class BaseAmbulanceRepository {
  Future<List<AmbulanceModel>?> getAmbulances() async {}
}
