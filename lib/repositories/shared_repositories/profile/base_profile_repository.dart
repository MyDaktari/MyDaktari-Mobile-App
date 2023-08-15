// ignore_for_file: body_might_complete_normally_nullable

import 'dart:io';

class BaseProfileRepository {
  Future<String?> updateClientProfile({
    required String userId,
    required String name,
    required String dob,
    required String gender,
    required String phoneNumber,
    required File profilePicture,
  }) async {}
  Future<String?> updateDoctorProfile({
    required String userId,
    required String name,
    required String dob,
    required String gender,
    required String phoneNumber,
    required File profilePicture,
  }) async {}
}
