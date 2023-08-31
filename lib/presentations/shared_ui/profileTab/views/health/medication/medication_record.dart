import 'package:flutter/material.dart';

class MedicationRecord extends StatelessWidget {
  const MedicationRecord({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text('Usilun'),
        subtitle: Text('Date and Time'),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Dosage'),
            Text('10 units'),
          ],
        ),
      ),
    );
  }
}
