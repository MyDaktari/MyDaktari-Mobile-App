import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/constants/colors.dart';
import 'package:my_daktari/logic/bloc/shared_bloc/blood_sugar/blood_sugar_bloc.dart';
import 'package:my_daktari/presentations/widgets/custom_loading.dart';

import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../../../../models/blood_sugar.dart';

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
            child: SizedBox(
              height: size.height * 0.4,
              width: size.width,
              child: SfCartesianChart(
                primaryXAxis: DateTimeAxis(
                  // Display only data for the last 7 days
                  visibleMaximum:
                      DateTime.parse(state.records.last.dateTime.toString()),
                  visibleMinimum:
                      DateTime.parse(state.records.last.dateTime.toString())
                          .subtract(const Duration(days: 6)),
                ),
                series: <ChartSeries>[
                  SplineAreaSeries<BloodSugarModel, DateTime>(
                      dataSource: state.records,
                      xValueMapper: (BloodSugarModel reading, _) =>
                          DateTime.parse(reading.dateTime!),
                      yValueMapper: (BloodSugarModel reading, _) =>
                          reading.glucoseLevel,
                      color: AppColor.primaryColor.withOpacity(.15),
                      borderColor: AppColor.lightGreen,
                      borderWidth: 3),
                ],
                zoomPanBehavior:
                    ZoomPanBehavior(enablePanning: true, enablePinching: true),
              ),
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
