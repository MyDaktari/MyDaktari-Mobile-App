import 'package:flutter/material.dart';
import '../../../constants/routes/route.dart' as route;
import 'package:my_daktari/models/appointment.dart';

import '../../../constants/constants.dart';

class DoctorAppointmentCard extends StatelessWidget {
  const DoctorAppointmentCard({super.key, required this.doctorAppointment});
  final AppointmentModel doctorAppointment;
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, route.appointmentDetails,
            arguments: doctorAppointment),
        child: Card(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          color: primaryColor,
          child: SizedBox(
            height: 110,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(right: size.width * .04),
                    decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20)),
                    child: Image.asset('assets/images/male-user.png'),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(doctorAppointment.name!,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.bold)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('${doctorAppointment.conditions!} -',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(width: 10),
                          Text('${doctorAppointment.startTime!}AM - 10AM',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
