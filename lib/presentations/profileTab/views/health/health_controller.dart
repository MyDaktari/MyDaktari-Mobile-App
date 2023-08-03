import 'package:flutter/foundation.dart';
import 'package:health/health.dart';
import 'package:my_daktari/presentations/profileTab/views/health/health_repository.dart';
import 'package:permission_handler/permission_handler.dart';

class HealthController {
  final repository = HealthRepository();

  // Future<void> setHealthData() async {
  //   print('111111111111');

  //   repository.setSteps();
  //   // repository.getHeight();
  // }

  Future<void> getHealthData() async {
    repository.getBloodOxygen();
    // repository.getHeight();
  }
}
