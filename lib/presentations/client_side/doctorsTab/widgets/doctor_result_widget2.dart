import 'package:flutter/material.dart';
import 'package:my_daktari/models/models.dart';

import '../../../../constants/route.dart' as route;

class DoctorResultWidget2 extends StatelessWidget {
  const DoctorResultWidget2({super.key, required this.doctor});

  final DoctorProfileModel doctor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(route.doctorProfile, arguments: doctor),
      child: Container(
        height: 220,
        width: size.width,
        decoration: BoxDecoration(
            color: Colors.grey[100], borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                'assets/images/male-user.png',
                height: 90,
              ),
              Text(doctor.name ?? ''),
              Text(
                doctor.speciality ?? '',
                style: textTheme.titleLarge?.copyWith(fontSize: 10),
              ),
              Text(
                  '${doctor.experienceYears?.toString() ?? ''} Years Experience | 12.7 Km'),
              Text(doctor.speciality ?? ''),
              Container(
                height: 20,
                width: 40,
                decoration: BoxDecoration(
                    border: Border.all(width: 2, color: Colors.grey),
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                      Icon(
                        Icons.star,
                        color: Colors.amber,
                        size: 15,
                      ),
                      Text(
                        '5.0',
                        style: TextStyle(fontSize: 9),
                      )
                    ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
