// ignore_for_file: body_might_complete_normally_nullable

import '../../models/models.dart';

abstract class BaseAuthenticationRepository {
  Future<bool?> logOut() async {}
  Future<Map<String, dynamic>?> checkUser() async {}
  Future<ClientModel?> loginClient(
      {required String username, required String password}) async {}
  Future<ClientModel?> registerClient(
      {required String name,
      required String password,
      required String phone,
      required String dob,
      required String gender,
      required String email,
      required String address}) async {}

  Future<DoctorModel?> loginDoctor(
      {required String username, required String password}) async {}
  Future<DoctorModel?> registerDoctor(
      {required String name,
      required String password,
      required String phone,
      required String dob,
      required String gender,
      required String email}) async {}

  Future<String?> otpRequest({required String phoneNumber}) async {}
  Future<String?> otpVerification(
      {required String phoneNumber, required String otp}) async {}
  Future<String?> sendToken({required email}) async {}
  Future<String?> resetPassword(
      {required token,
      required password,
      required confirmPassword,
      required email}) async {}
}
