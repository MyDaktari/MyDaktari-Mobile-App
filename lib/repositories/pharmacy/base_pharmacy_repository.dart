import '../../models/pharmacy.dart';

abstract class BasePharmacyRepository {
  Future<List<PharmacyModel>?> getPharmacy() async {}
}
