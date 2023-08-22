import '../../../models/suborder_model.dart';

abstract class BaseShopRepository {
  Future<String?> makePayment(
      {required String appointmentID,
      required String amount,
      required String phoneNumber}) async {}
  Future<Map<String, String>?> placeOrder(
      {required String userId,
      required String phoneNumber,
      required String totalAmount,
      required String address,
      required String optionalInfo,
      required List<SubOrdersModel> products}) async {}
}
