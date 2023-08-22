import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:my_daktari/models/suborder_model.dart';
import '../../../constants/urls.dart';
import 'base_shop_repository.dart';

class ShopRepository extends BaseShopRepository {
  @override
  Future<Map<String, String>> placeOrder({
    required String userId,
    required String phoneNumber,
    required String address,
    required String totalAmount,
    required String optionalInfo,
    required List<SubOrdersModel> products,
  }) async {
    final List<Map<String, dynamic>> items =
        products.map((product) => product.toMapWithSelectedFields()).toList();

    final payload = {
      "userID": userId,
      "totalAmount": totalAmount,
      "shippingAddress": address,
      "contactNumber": "254${phoneNumber.substring(1)}",
      "paymentMethod": "M-pesa",
      "additionalInformation": optionalInfo,
      "items": items,
    };

    final response = await http.post(Uri.parse(makeShopOrderUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(payload));
    print('################28################');
    print(response.body);
    if (response.statusCode == 200) {
      return {
        "message": jsonDecode(response.body)["message"],
        "orderID": jsonDecode(response.body)["orderID"]
      };
    } else {
      throw Exception('Failed to place your order, please try again later');
    }
  }

  @override
  Future<String> makePayment(
      {required String appointmentID,
      required String amount,
      required String phoneNumber}) async {
    final response = await http.post(Uri.parse(makePaymentUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "orderCode": appointmentID,
          "totalAmount": amount,
          "contactNumber": "254${phoneNumber.substring(1)}"
        }));
    print('################5555################');
    print(response.body);
    if (response.statusCode == 200) {
      return jsonDecode(response.body)["message"];
    } else {
      throw Exception('Failed to make payment, please try again later');
    }
  }
}
