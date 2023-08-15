import 'package:flutter/material.dart';
import 'package:my_daktari/presentations/widgets/scroll_behavior.dart';

Future<Future> healthInfoDialog(BuildContext context) async {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Health Tracking'),
        content: ScrollConfiguration(
          behavior: MyBehavior(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Health tracking is a feature that allows you to monitor your fitness and well-being with the help of Google Fit integration. The app offers the following benefits:',
                ),
                SizedBox(height: 8),
                Text(
                    '1. Steps Tracking: Keep track of your daily steps and set fitness goals.'),
                Text(
                    '2. Heart Rate Monitoring: Monitor your heart rate during various activities.'),
                Text(
                    '3. Distance Tracking: Measure the distance covered during walks, runs, and cycling.'),
                Text(
                    '4. Calories Burned: Estimate the calories burned during exercises.'),
                Text(
                    '5. Sleep Monitoring: Understand your sleep patterns and quality.'),
                Text(
                    '6. Water Intake Tracking: Keep track of your daily water consumption.'),
                Text(
                    '7. Physical Activity Recognition: Automatically detect various activities.'),
                Text(
                    '8. Heart Points and Move Minutes: Set activity goals and achieve milestones.'),
                Text(
                    '10. Fitness Goals and Recommendations: Receive personalized fitness advice.'),
              ],
            ),
          ),
        ),
        actionsAlignment: MainAxisAlignment.center,
        actions: [
          TextButton(
              onPressed: () => Navigator.of(context).pop(), child: Text('OK'))
        ],
      );
    },
  );
}
