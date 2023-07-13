import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/logic/bloc/client_bloc/doctor_time_slots/doctor_time_slots_bloc.dart';
import 'package:my_daktari/logic/cubit/booking_info/booking_info_cubit.dart';

import '../../../../models/doctor_profile_model.dart';
import 'package:my_daktari/constants/route.dart' as route;

class SelectSession extends StatelessWidget {
  SelectSession({super.key, required this.doctor});
  final DoctorProfileModel doctor;

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> sessions = [
      {
        'title': 'Chat',
        'price': doctor.charges!.first.chat,
        'description': 'Pricing is done per session'
      },
      {
        'title': 'Phone Call',
        'price': doctor.charges!.first.phoneCall,
        'description': 'Pricing is done per session'
      },
      {
        'title': 'Video call',
        'price': doctor.charges!.first.videoCall,
        'description': 'Pricing is done per session'
      },
    ];
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back_ios)),
          ),
          const Text('Select an option'),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: sessions
                  .map((session) => GestureDetector(
                        onTap: () {
                          print(session['title'].toString());
                          Navigator.pop(context);
                          context.read<DoctorTimeSlotsBloc>().add(
                              LoadDoctorTimeSlots(
                                  doctorId: doctor.doctorID.toString(),
                                  date: DateTime.now()));
                          context.read<BookingInfoCubit>().updateBookingInfo(
                              meetingOption: session['title'].toString());
                          Navigator.pushNamed(context, route.bookingScreen);
                          // showModalBottomSheet(
                          //   barrierColor: Colors.transparent,
                          //   useSafeArea: true,
                          //   context: context,
                          //   isScrollControlled: true,
                          //   builder: (context) => DoctorBookingView(
                          //       doctor: doctor,
                          //       meetingOption: session['title'].toString()),
                          // );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 150,
                            width: size.width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: const Color.fromARGB(66, 1, 84, 186)),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    session['title'].toString().toUpperCase(),
                                    style: textTheme.titleLarge?.copyWith(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text('KSH ${session['price']}'),
                                  Text(session['description']),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Gift Voucher Code',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20))),
            ),
          ),
          ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).primaryColor),
              onPressed: () {},
              child: const Text('Check Voucher'))
        ],
      ),
    );
  }
}
