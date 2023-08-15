import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_daktari/models/client_appointment.dart';

import '../../../constants/colors.dart';

class ClientAppointmentCard extends StatelessWidget {
  const ClientAppointmentCard({Key? key, required this.clientAppointment})
      : super(key: key);

  final ClientAppointment clientAppointment;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    String formattedDate = '';

    try {
      final parsedDate = DateTime.parse(clientAppointment.date.toString());
      formattedDate = DateFormat('EEEE, d MMMM yyyy').format(parsedDate);
    } catch (e) {
      // Handle the invalid date format
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          color: AppColor.primaryColor,
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
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Image.asset('assets/images/male-user.png'),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        clientAppointment.doctorsName!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '${clientAppointment.appointmentStatus} -',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            '${clientAppointment.startTime!}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      Text(
                        formattedDate,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                        ),
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
