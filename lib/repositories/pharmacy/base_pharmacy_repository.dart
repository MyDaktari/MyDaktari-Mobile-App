// ignore_for_file: body_might_complete_normally_nullable

import '../../models/pharmacy.dart';

abstract class BasePharmacyRepository {
  Future<List<PharmacyModel>?> getPharmacy() async {}
}
