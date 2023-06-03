import 'package:flutter/material.dart';
import 'package:my_daktari/constants/routes/route.dart' as route;
import 'appointment_card.dart';

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
        : Center(
            child: Column(
            children: [
              Text('You\'ve got nothing yet'),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, route.personalInfo);
                },
                child: Text('Complete your profile'),
              )
            ],
          ));
  }
}
