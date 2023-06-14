import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/presentations/client_side/doctorsTab/views/select_session.dart';

import '../../../../logic/cubit/booking_info/booking_info_cubit.dart';
import '../../../../models/doctor_profile_model.dart';

class DoctorProfileSummaryPage extends StatelessWidget {
  const DoctorProfileSummaryPage({super.key, required this.doctor});
  final DoctorProfileModel doctor;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite_outline))
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Center(
                      child: Image.asset('assets/images/male-user.png',
                          height: 180, fit: BoxFit.fitHeight)),
                  Text(doctor.name ?? ''),
                  Text(doctor.title ?? '',
                      style: textTheme.titleLarge?.copyWith(
                          fontSize: 15, fontWeight: FontWeight.w300)),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.schedule,
                                color: Theme.of(context).primaryColor),
                            const SizedBox(width: 5),
                            Text(doctor.openingHours?.weekdays ?? '')
                          ],
                        ),
                        Container(
                          height: 20,
                          width: 40,
                          decoration: BoxDecoration(
                              border: Border.all(width: 2, color: Colors.grey),
                              borderRadius: BorderRadius.circular(12)),
                          child: Center(
                              child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: const [
                                Icon(Icons.star, color: Colors.amber, size: 15),
                                Text('5.0', style: TextStyle(fontSize: 9))
                              ])),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: size.width,
                    child: Wrap(
                      alignment: WrapAlignment.spaceBetween,
                      children: [
                        Text('Experience: ${doctor.experienceYears} Years'),
                        Text('Speciality: ${doctor.speciality}')
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: size.width,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2.5, color: Colors.grey),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.grey[100],
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Overview'),
                              const SizedBox(
                                height: 20,
                              ),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Text(
                                    doctor.overview ?? '',
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.justify,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    fixedSize: Size(size.width * .8, 50)),
                onPressed: () {
                  print(doctor.name);
                  context.read<BookingInfoCubit>().updateBookingInfo(
                      userId: userId, doctorId: doctor.doctorID.toString());
                  showModalBottomSheet(
                    barrierColor: Colors.transparent,
                    useSafeArea: true,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => SelectSession(doctor: doctor),
                  );
                },
                child: const SizedBox(
                    width: 120, child: Center(child: Text('Book'))))
          ],
        ),
      ),
    );
  }
}
