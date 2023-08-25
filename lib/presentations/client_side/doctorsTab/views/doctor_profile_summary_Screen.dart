import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/presentations/client_side/doctorsTab/views/select_session.dart';

import '../../../../constants/colors.dart';
import '../../../../logic/cubit/booking_info/booking_info_cubit.dart';
import '../../../../models/doctor_profile_model.dart';
import '../widgets/doctor_image_widget.dart';

class DoctorProfileSummaryPage extends StatelessWidget {
  const DoctorProfileSummaryPage({super.key, required this.doctor});
  final DoctorProfileModel doctor;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DoctorImageWidget(imageUrl: doctor.image.toString(), size: 170),
                SizedBox(height: 10),
                Stack(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(doctor.name ?? '',
                            style: textTheme.titleLarge!
                                .copyWith(fontSize: 24, color: Colors.black)),
                        const SizedBox(width: 5),
                        Column(
                          children: [
                            Icon(Icons.stars_rounded,
                                color: AppColor.primaryColor, size: 20),
                            const Text('')
                          ],
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(doctor.title ?? '',
                    style: textTheme.titleLarge
                        ?.copyWith(fontSize: 15, fontWeight: FontWeight.w300)),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 20),
                const Text('About',
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'Speciality: ',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  TextSpan(
                      text: doctor.speciality.toString(),
                      style: TextStyle(color: Colors.black))
                ])),
                const SizedBox(height: 5),
                RichText(
                    text: TextSpan(children: [
                  TextSpan(
                      text: 'Experience: ',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  TextSpan(
                      text: '${doctor.experienceYears} Years',
                      style: TextStyle(color: Colors.black))
                ])),
                const SizedBox(height: 10),
                Text(doctor.overview.toString(), textAlign: TextAlign.justify)
              ],
            ),
            Spacer(),
            BlocBuilder<BookingInfoCubit, BookingInfoState>(
              builder: (context, state) {
                return Visibility(
                    visible: state.symptomID.isNotEmpty,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryColor,
                            fixedSize: Size(size.width * .8, 50)),
                        onPressed: () {
                          context.read<BookingInfoCubit>().updateBookingInfo(
                              userId: userId,
                              doctorId: doctor.doctorID.toString());
                          showModalBottomSheet(
                            barrierColor: Colors.transparent,
                            useSafeArea: true,
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => SelectSession(doctor: doctor),
                          );
                        },
                        child: const SizedBox(
                          child: Center(
                              child: Text('Book Appointment',
                                  style:
                                      TextStyle(fontWeight: FontWeight.w700))),
                        )));
              },
            ),
            const SizedBox(height: 20)
          ],
        ),
      ),
    );
  }
}
