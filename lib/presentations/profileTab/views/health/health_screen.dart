import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:my_daktari/constants/constants.dart';

import 'package:my_daktari/presentations/profileTab/views/health/health_controller.dart';
import 'package:my_daktari/presentations/profileTab/views/health/widget/bar_chart/graph_card.dart';

import '../../widgets/health_info_dialog.dart';
import 'widget/summary.dart';

class HealthScreen extends StatelessWidget {
  HealthScreen({super.key});

  HealthController healthController = HealthController();
  List<double> weeklySummary = [500, 125, 116, 252, 63, 700, 500];
  List<double> weeklyDistanceSummary = [2, 5, .5, 4, 2, 4, 3];

  @override
  Widget build(BuildContext context) {
    // healthController.getHealthData();
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
                  ],
                ),
              ),
            ),
            SizedBox(height: 10.0),
            // Health Data Chart Section
            Card(
              child: Container(
                height: 100,
                alignment: Alignment.center,
                padding: EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.water_drop_rounded,
                          color: Colors.red,
                        ),
                        Text('Blood glucose',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold))
                      ],
                    ),
                    Row(
                      children: [
                        Text('0.2',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: primaryColor)),
                        Text(' mmo;/L', style: TextStyle(fontSize: 15)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Energy expended (kcal)',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10.0),
                    Text('Last 7 days', style: TextStyle(fontSize: 15)),
                    Container(
                      height: 200,
                      child: MyBarGraph(weeklySummary: weeklySummary),
                    )
                  ],
                ),
              ),
            ),
            Card(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Distance covered in km',
                        style: TextStyle(
                            fontSize: 18.0, fontWeight: FontWeight.bold)),
                    SizedBox(height: 10.0),
                    Text('Last 7 days', style: TextStyle(fontSize: 15)),
                    Container(
                      height: 200,
                      child: MyBarGraph(weeklySummary: weeklyDistanceSummary),
                    )
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
