import 'package:health/health.dart';

class HealthRepository {
  final health = HealthFactory();
  Future<bool> getBloodOxygen() async {
    bool requested = await health.requestAuthorization([
      //HealthDataType.BLOOD_GLUCOSE,
      HealthDataType.HEIGHT,
      HealthDataType.BLOOD_OXYGEN,
      HealthDataType.STEPS,
      HealthDataType.HEART_RATE,
      HealthDataType.BODY_MASS_INDEX,
      HealthDataType.BODY_FAT_PERCENTAGE,
      HealthDataType.ACTIVE_ENERGY_BURNED,
      HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
      HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
      HealthDataType.BLOOD_GLUCOSE,
      HealthDataType.WEIGHT,

      // HealthDataType.BLOOD_GLUCOSE,
      // HealthDataType.STEPS
    ]);

    if (requested) {
      var now = DateTime.now();
      List<HealthDataPoint> healthData = await health
          .getHealthDataFromTypes(now.subtract(Duration(days: 7)), now, [
        HealthDataType.HEIGHT,
        HealthDataType.BLOOD_OXYGEN,
        HealthDataType.STEPS,
        HealthDataType.HEART_RATE,
        HealthDataType.BODY_MASS_INDEX,
        HealthDataType.BODY_FAT_PERCENTAGE,
        HealthDataType.ACTIVE_ENERGY_BURNED,
        HealthDataType.BLOOD_PRESSURE_DIASTOLIC,
        HealthDataType.BLOOD_PRESSURE_SYSTOLIC,
        HealthDataType.BLOOD_GLUCOSE,
        HealthDataType.WEIGHT,
      ]);
      return healthData.isNotEmpty;
    }
    return false;
  }

  // Future<bool> setSteps() async {
  //   await Permission.activityRecognition.request();
  //   await Permission.location.request();
  //   bool requested = await health.requestAuthorization([
  //     //HealthDataType.BLOOD_GLUCOSE,
  //     HealthDataType.HEIGHT,
  //     HealthDataType.BLOOD_OXYGEN,
  //     HealthDataType.STEPS
  //   ]);

  //   if (requested) {
  //     var now = DateTime.now();
  //     bool success = await health.writeHealthData(
  //         10, HealthDataType.STEPS, now.subtract(Duration(hours: 1)), now);
  //     print('############');
  //     print(success);
  //     return success;
  //   }
  //   return false;
  // }
}


/*
// create a HealthFactory for use in the app, choose if HealthConnect should be used or not
    HealthFactory health = HealthFactory(useHealthConnectIfAvailable: true);

    // define the types to get
    var types = [
      HealthDataType.HEIGHT,
      HealthDataType.BLOOD_GLUCOSE,
    ];

    // requesting access to the data types before reading them
    bool requested = await health.requestAuthorization(types);

    var now = DateTime.now();

    // fetch health data from the last 24 hours
    List<HealthDataPoint> healthData = await health.getHealthDataFromTypes(
        now.subtract(Duration(days: 1)), now, types);

    // request permissions to write steps and blood glucose
    types = [HealthDataType.HEIGHT, HealthDataType.BLOOD_GLUCOSE];
    var permissions = [
      HealthDataAccess.READ_WRITE,
      HealthDataAccess.READ_WRITE
    ];
    await health.requestAuthorization(types, permissions: permissions);
    print('#####################');
    print(await health.requestAuthorization(types, permissions: permissions));

    // write steps and blood glucose
    bool success =
        await health.writeHealthData(10, HealthDataType.HEIGHT, now, now);
    success = await health.writeHealthData(
        3.1, HealthDataType.BLOOD_GLUCOSE, now, now);

    print(success);

    // get the number of steps for today
    var midnight = DateTime(now.year, now.month, now.day);
    int? steps = await health.getTotalStepsInInterval(midnight, now);
    print(healthData);
  }
 */