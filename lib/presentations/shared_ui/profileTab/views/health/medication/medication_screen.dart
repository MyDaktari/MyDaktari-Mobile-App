import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../../../constants/route.dart' as route;
import 'package:my_daktari/constants/colors.dart';

import 'medication_record.dart';

class MedicationScreen extends StatelessWidget {
  const MedicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Medication'),
        ),
        body: ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            return MedicationRecord();
          },
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: AppColor.lightGreen,
          onPressed: () =>
              Navigator.pushNamed(context, route.recordMedicationScreen),
          child: Icon(Icons.add),
        ));
  }
}
