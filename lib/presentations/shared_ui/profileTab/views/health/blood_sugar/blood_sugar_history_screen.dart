import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:my_daktari/constants/colors.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/presentations/widgets/scroll_behavior.dart';
import '../../../../../../logic/bloc/shared_bloc/blood_sugar/blood_sugar_bloc.dart';
import '../../../../../../models/blood_sugar.dart';

class DetailedRecordsScreen extends StatelessWidget {
  final List<BloodSugarModel> records;

  DetailedRecordsScreen({required this.records});

  @override
  Widget build(BuildContext context) {
    Map<String, List<BloodSugarModel>> groupedRecords = {};

    // Group records by date
    for (var record in records) {
      String date = record.dateTime!.split('T')[0];
      if (groupedRecords.containsKey(date)) {
        groupedRecords[date]!.add(record);
      } else {
        groupedRecords[date] = [record];
      }
    }

    // Sort the keys (dates) in descending order
    List<String> sortedDates = groupedRecords.keys.toList()
      ..sort((a, b) => b.compareTo(a));

    String _formatDate(String date) {
      DateTime dateTime = DateTime.parse(date);
      return DateFormat('E, d-MM-yyyy').format(dateTime);
    }

    String _formatTime(String time) {
      DateTime dateTime = DateTime.parse('2023-09-06T$time');
      return DateFormat('h:mm a').format(dateTime);
    }

    double _calculateAverage(List<BloodSugarModel> records) {
      double totalGlucose = records.fold(
          0.0, (sum, record) => sum + (record.glucoseLevel ?? 0.0));
      return totalGlucose / records.length;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Detailed Records'),
      ),
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: RefreshIndicator(
          onRefresh: () async {
            // Refresh the records
            BlocProvider.of<BloodSugarBloc>(context)
                .add(LoadBloodSugarRecord(userId: userId));
          },
          child: ListView.builder(
            itemCount: sortedDates.length, // Use the sorted dates
            itemBuilder: (BuildContext context, int index) {
              String date =
                  sortedDates[index]; // Get the date from the sorted list
              List<BloodSugarModel> recordsForDate = groupedRecords[date]!;

              return Card(
                margin: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text('Date: ${_formatDate(date)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: AppColor.blackText,
                          )),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: recordsForDate.map((record) {
                        String time = record.dateTime!
                            .split('T')[1]; // Extract time part only
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 4.0),
                          child: Text(
                            'Time: ${_formatTime(time)} | Glucose Level: ${record.glucoseLevel ?? 0.toStringAsFixed(2)} mg/dL',
                            style: TextStyle(
                                fontSize: 16, color: AppColor.blackText),
                          ),
                        );
                      }).toList(),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        'Average: ${_calculateAverage(recordsForDate).toStringAsFixed(2)}',
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.primaryColor),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
