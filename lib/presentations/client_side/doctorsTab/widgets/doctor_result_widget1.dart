import 'package:flutter/material.dart';
import 'package:my_daktari/constants/colors.dart';

import '../../../../models/doctor_profile_model.dart';
import '../../../../constants/route.dart' as route;
import 'doctor_image_widget.dart';

class DoctorResultWidget1 extends StatelessWidget {
  const DoctorResultWidget1({super.key, required this.doctor});
  final DoctorProfileModel doctor;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return GestureDetector(
      onTap: () => Navigator.of(context)
          .pushNamed(route.doctorProfile, arguments: doctor),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(color: AppColor.lightGrey)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: size.width * .4,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 20,
                      child: Text((doctor.name ?? ''),
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.titleLarge?.copyWith(fontSize: 15))),
                  SizedBox(
                      height: 20,
                      child: Text(doctor.speciality ?? '',
                          overflow: TextOverflow.ellipsis,
                          style: textTheme.titleLarge?.copyWith(fontSize: 15))),
                  const SizedBox(height: 10),
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
                          Icon(Icons.star, color: Colors.grey, size: 15),
                          Text('5.0', style: TextStyle(fontSize: 9))
                        ])),
                  ),
                  const SizedBox(height: 10),
                  DoctorImageWidget(imageUrl: doctor.image.toString()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
