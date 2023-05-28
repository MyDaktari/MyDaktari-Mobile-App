import 'package:flutter/material.dart';

import 'doctor_appointment_card.dart';

class AppointmentTab extends StatelessWidget {
  const AppointmentTab({super.key, required this.list});
  final List list;
  @override
  Widget build(BuildContext context) {
    return list.isNotEmpty
        ? ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return DoctorAppointmentCard(
                doctorAppointment: list.elementAt(index),
              );
            })
        : Center(child: Text('You\'ve got nothing yet'));
  }
}
