import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_daktari/constants/colors.dart';

import '../../../../../../models/medication.dart';

class MedicationRecord extends StatelessWidget {
  const MedicationRecord({super.key, required this.medicationModel});
  final MedicationModel medicationModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(medicationModel.medicationName.toString(),
            style: TextStyle(fontWeight: FontWeight.bold)),
        //format the medicationModel.dateTime to be more readable as 1 sep 2023 12:00 AM

        subtitle: Text(DateFormat("d MMM y h:mm a")
            .format(DateTime.parse(medicationModel.dateTime.toString()))),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Dosage',
                style: TextStyle(
                    fontSize: 12.0,
                    color: AppColor.blackText,
                    fontWeight: FontWeight.bold)),
            SizedBox(height: 5.0),
            Text('${medicationModel.dosage.toString()} units'),
          ],
        ),
      ),
    );
  }
}
