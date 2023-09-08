import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/constants/colors.dart';
import 'package:my_daktari/logic/bloc/shared_bloc/blood_sugar/blood_sugar_bloc.dart';
import 'package:my_daktari/presentations/widgets/custom_loading.dart';

import 'package:syncfusion_flutter_charts/charts.dart';
import '../../../../../../../constants/route.dart' as route;
import '../../../../../../../models/blood_sugar.dart';
// import '../blood_sugar_history_screen.dart';

class BloodGraph extends StatelessWidget {
  const BloodGraph({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<BloodSugarBloc, BloodSugarState>(
      builder: (context, state) {
        if (state is BloodSugarLoading) {
          return Container(
              height: size.height * .6,
              child: const Center(child: CustomLoading()));
        } else if (state is BloodSugarLoadSuccess) {
          // Group records by date (ignoring time)
          Map<String, List<BloodSugarModel>> groupedRecords = {};

          for (var record in state.records) {
            String date =
                record.dateTime!.split('T')[0]; // Extract date part only

            if (groupedRecords.containsKey(date)) {
              groupedRecords[date]!.add(record);
            } else {
              groupedRecords[date] = [record];
            }
          }

          // Calculate average glucose level for each day
          List<BloodSugarModel> averagedRecords = [];
          groupedRecords.forEach((date, records) {
            double totalGlucose = records.fold(
                0.0, (sum, record) => sum + (record.glucoseLevel ?? 0.0));
            double averageGlucose = totalGlucose / records.length;
            BloodSugarModel averagedRecord = BloodSugarModel(
              dateTime: date, // Use date as dateTime (ignoring time)
              glucoseLevel: averageGlucose,
            );
            averagedRecords.add(averagedRecord);
            print(averagedRecords.length);
            print(state.records.length);
          });
          return Visibility(
            visible: state.records.isNotEmpty,
            replacement: Column(children: [
              Text('No readings yet',
                  style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: AppColor.primaryColor)),
              SizedBox(height: 10.0),
              Text('Tap the + button to add a reading',
                  style: TextStyle(fontSize: 15))
            ]),
            child: Column(
              children: [
                SizedBox(
                  height: size.height * 0.4,
                  width: size.width,
                  child: SfCartesianChart(
                    tooltipBehavior: TooltipBehavior(
                        enable: true,
                        color: AppColor.primaryColor,
                        decimalPlaces: 1,
                        header: 'avg. Blood Sugar',
                        textStyle: TextStyle(color: Colors.white)),
                    primaryXAxis: DateTimeAxis(
                      // Display only data for the last 7 days
                      visibleMaximum: DateTime.parse(
                          averagedRecords.last.dateTime.toString()),
                      visibleMinimum: DateTime.parse(
                              averagedRecords.last.dateTime.toString())
                          .subtract(const Duration(days: 30)),
                    ),
                    series: <ChartSeries>[
                      SplineAreaSeries<BloodSugarModel, DateTime>(
                          dataSource: averagedRecords,
                          xValueMapper: (BloodSugarModel reading, _) =>
                              DateTime.parse(reading.dateTime!),
                          yValueMapper: (BloodSugarModel reading, _) =>
                              reading.glucoseLevel,
                          color: AppColor.primaryColor.withOpacity(.15),
                          borderColor: AppColor.lightGreen,
                          borderWidth: 3,
                          markerSettings: MarkerSettings(
                              isVisible: true,
                              color: AppColor.primaryColor,
                              width: 7,
                              height: 7))
                    ],
                    zoomPanBehavior: ZoomPanBehavior(
                        zoomMode: ZoomMode.x,
                        enablePinching: true,
                        enableDoubleTapZooming: true,
                        enablePanning: true,
                        enableSelectionZooming: true,
                        enableMouseWheelZooming: true),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pushNamed(
                      context, route.bloodGlucoseHistoryScreen,
                      arguments: state.records),
                  child: Text('View all readings',
                      style: TextStyle(
                          color: AppColor.primaryColor, fontSize: 16.0)),
                ),
              ],
            ),
          );
        }
        if (state is BloodSugarsLoadinFailed) {
          return Center(
            child: Column(
              children: [
                Text(state.message),
                ElevatedButton(
                    onPressed: () {
                      context
                          .read<BloodSugarBloc>()
                          .add(LoadBloodSugarRecord(userId: 'userId'));
                    },
                    child: const Text('Retry'))
              ],
            ),
          );
        } else {
          return SizedBox();
        }
      },
    );
  }
}
