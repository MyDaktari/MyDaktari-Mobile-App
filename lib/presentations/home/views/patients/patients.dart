import 'package:flutter/material.dart';
import 'package:my_daktari/presentations/home/views/appointments/patient_appointments.dart';

class PatientsTab extends StatelessWidget {
  const PatientsTab({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Patients',
            style: textTheme.titleLarge,
          ),
          Expanded(child: AppointmentList(list: [1, 2, 3, 4, 5])),
        ],
      ),
    );
  }
}
