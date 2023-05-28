import '../../models/ambulance.dart';

abstract class BaseAmbulanceRepository {
  Future<List<AmbulanceModel>?> getAmbulances() async {}
}
