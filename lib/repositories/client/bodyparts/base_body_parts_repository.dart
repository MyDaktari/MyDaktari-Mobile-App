import 'package:my_daktari/models/body_part_model.dart';

abstract class BaseBodyPartsRepository {
  Future<List<BodyPartModel>?> getBodyParts() async {
    return null;
  }
}
