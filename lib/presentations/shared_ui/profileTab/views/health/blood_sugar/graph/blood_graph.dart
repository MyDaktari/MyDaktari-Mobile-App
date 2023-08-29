import 'dart:math';

import 'package:flutter/material.dart';
import 'package:my_daktari/constants/colors.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../../constants/enums.dart';
import '../../../../../../../models/blood_sugar.dart';

class BloodGraph extends StatelessWidget {
  const BloodGraph({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    List<BloodSugarReading> _readings = [];
    Map<DateTime, List<double>> _groupedReadings = {};

    void _generateSampleData() {
      final now = DateTime.now();
      final random = Random();

      _readings = List.generate(60, (index) {
        final dateTime = now.subtract(Duration(days: 30 - index));
        final glucoseLevel =
            random.nextDouble() * 100 + 80; // Random value between 80 and 180
        return BloodSugarReading(
            dateTime: dateTime,
            glucoseLevel: glucoseLevel,
            mealType: MealType.beforeMeal,
            note: '');
      });
    }

    _generateSampleData();
    return SizedBox(
      height: size.height * 0.5,
      width: size.width,
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(
            // Display only data for the last 7 days
            visibleMaximum: _readings.last.dateTime,
            visibleMinimum:
                _readings.last.dateTime.subtract(const Duration(days: 6))),
        series: <ChartSeries>[
          SplineAreaSeries<BloodSugarReading, DateTime>(
            dataSource: _readings,
            xValueMapper: (BloodSugarReading reading, _) => reading.dateTime,
            yValueMapper: (BloodSugarReading reading, _) =>
                reading.glucoseLevel,
            color: AppColor.primaryColor.withOpacity(.15),
            gradient: LinearGradient(
              colors: [
                AppColor.primaryColor.withOpacity(.05),
                AppColor.primaryColor.withOpacity(.2),
              ],
              stops: [0.1, 0.9],
            ),
            borderColor: AppColor.lightGreen,
            borderWidth: 3,
          ),
        ],
        zoomPanBehavior:
            ZoomPanBehavior(enablePanning: true, enablePinching: true),
      ),
    );
  }
}
