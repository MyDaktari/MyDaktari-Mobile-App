import 'dart:io';

import 'package:file_picker/file_picker.dart';

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
    required PlatformFile profilePicture,
  }) async {}
}
