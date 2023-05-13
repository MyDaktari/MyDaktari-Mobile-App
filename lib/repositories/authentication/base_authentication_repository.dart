import '../../models/client.dart';

abstract class BaseAuthenticationRepository {
  Future<Client?> login(
      {required String username, required String password}) async {}
}
