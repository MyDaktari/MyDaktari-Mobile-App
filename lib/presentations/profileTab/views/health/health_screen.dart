import 'package:flutter/material.dart';
import 'package:my_daktari/presentations/profileTab/views/health/health_controller.dart';

import '../../widgets/health_info_dialog.dart';

class HealthScreen extends StatelessWidget {
  HealthScreen({super.key});

  HealthController healthController = HealthController();

  @override
  Widget build(BuildContext context) {
    healthController.getHealthData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Health Tracking'),
        actions: [
          IconButton(
              onPressed: () => healthInfoDialog(context),
              icon: Icon(Icons.info_outline_rounded, size: 30.0))
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Health Summary Section
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'User Health Summary',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    HealthSummaryTile(label: 'Steps', value: '8000'),
                    HealthSummaryTile(label: 'Heart Rate', value: '75'),
                    HealthSummaryTile(label: 'Distance', value: '5.3 km'),
                    HealthSummaryTile(label: 'Calories Burned', value: '460'),
                    SizedBox(height: 10.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            // Handle refresh data button click
                          },
                          child: Text('Refresh Data'),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Handle view more details button click
                          },
                          child: Text('View More Details'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20.0),

            // Health Data Chart Section
            Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Health Data Chart',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    // Add your health data chart widget here
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HealthSummaryTile extends StatelessWidget {
  final String label;
  final String value;

  HealthSummaryTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16.0)),
        Text(value,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
