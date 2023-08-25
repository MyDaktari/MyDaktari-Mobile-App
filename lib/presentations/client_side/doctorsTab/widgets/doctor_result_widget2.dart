import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:my_daktari/constants/colors.dart';
import 'package:my_daktari/models/models.dart';

import '../../../../constants/route.dart' as route;
import 'doctor_image_widget.dart';

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
        width: size.width,
        decoration: BoxDecoration(color: AppColor.lightGrey),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DoctorImageWidget(imageUrl: doctor.image.toString()),
              SizedBox(height: size.height * .02),
              Text(doctor.name ?? '',
                  style: textTheme.titleLarge!
                      .copyWith(fontSize: 22, fontWeight: FontWeight.bold)),
              SizedBox(height: size.height * .01),
              Text(doctor.speciality ?? '',
                  style: textTheme.titleMedium!
                      .copyWith(fontSize: 15, fontWeight: FontWeight.w600)),
              Text('Experience: ${doctor.experienceYears?.toString() ?? ''}'),
            ],
          ),
        ),
      ),
    );
  }
}
