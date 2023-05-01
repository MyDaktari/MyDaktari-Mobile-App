import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../mock/models/doctor_model.dart';
import 'package:my_daktari/routes/app_route.dart' as route;

class DoctorResultWidget1 extends StatelessWidget {
  const DoctorResultWidget1({
    super.key,
    required this.doctor,
  });
  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(route.doctorProfile, arguments: doctor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: (size.width / 2) - 28,
          decoration: BoxDecoration(
              border: Border.all(), borderRadius: BorderRadius.circular(20)),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                  child: Text(
                    (doctor.name ?? ''),
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleLarge?.copyWith(fontSize: 15),
                  ),
                ),
                SizedBox(
                  height: 20,
                  child: Text(
                    doctor.speciality ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleLarge?.copyWith(fontSize: 15),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
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
                          color: Colors.grey,
                          size: 15,
                        ),
                        Text(
                          '5.0',
                          style: TextStyle(fontSize: 9),
                        )
                      ])),
                ),
                const SizedBox(
                  height: 10,
                ),
                SvgPicture.asset(
                  doctor.image!,
                  height: 150,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
