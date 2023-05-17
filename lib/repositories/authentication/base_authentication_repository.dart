import '../../models/client.dart';

abstract class BaseAuthenticationRepository {
  Future<ClientModel?> login(
      {required String username, required String password}) async {}
  Future<ClientModel?> RegisterDoctor({
    required String name,
    required String password,
    required String phone,
    required String dob,
    required String gender,
    required String email,
    required String description,
  }) async {}
}
