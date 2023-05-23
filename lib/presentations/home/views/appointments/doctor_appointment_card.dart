import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_daktari/models/appointment.dart';

import '../../../../constants/constants.dart';

class DoctorAppointmentCard extends StatelessWidget {
  const DoctorAppointmentCard({super.key, required this.doctorAppointment});
  final AppointmentModel doctorAppointment;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        color: primaryColor,
        child: SizedBox(
          height: 110,
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Name: ',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold)),
                    Text(doctorAppointment.name!,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 21,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      DateFormat('E dd MMM yyyy').format(
                          DateTime.parse(doctorAppointment.date.toString())),
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                    Text(
                      'Time: ${doctorAppointment.startTime}',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text('Condition:  ',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600)),
                    Text(
                      doctorAppointment.conditions!,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
