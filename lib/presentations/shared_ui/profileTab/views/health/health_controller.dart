import 'package:my_daktari/presentations/shared_ui/profileTab/views/health/health_repository.dart';

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
