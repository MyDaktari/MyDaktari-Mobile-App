import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/logic/bloc/doctor_bloc/doctor_availability/bloc/doctor_availability_bloc.dart';
import 'package:my_daktari/presentations/doctor_side/schedule/widgets/clickable_times.dart';
import 'package:my_daktari/presentations/doctor_side/schedule/widgets/working_hours.dart';

import '../../../constants/constants.dart';
import '../../../logic/cubit/doctor_schedules/doctor_schedule.dart';

import 'models/dayschedule.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({Key? key}) : super(key: key);

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  late final ScheduleCubit scheduleCubit;

  @override
  void dispose() {
    scheduleCubit.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Initialize the schedules with default values
    final initialSchedules = daysOfWeek.map((day) {
      return DaySchedule(
        day: day,
        isEnabled: true,
        startTime: timeIntervals.first,
        endTime: timeIntervals.first,
      );
    }).toList();
    scheduleCubit = ScheduleCubit(initialSchedules);
  }

  String selectedTime = '30 min';

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScheduleCubit>.value(
      value: scheduleCubit,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Manage Appointments",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Connect with Medical Professionals Anytime, Anywhere',
                    style: TextStyle(fontSize: 16, color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Appointment Duration",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      color: primaryColor.withOpacity(0.05),
                      padding: const EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ClickableTime(
                            text: '15 min',
                            isSelected: selectedTime == '15 min',
                            onPressed: () {
                              setState(() {
                                selectedTime = '15 min';
                              });
                            },
                          ),
                          ClickableTime(
                            text: '30 min',
                            isSelected: selectedTime == '30 min',
                            onPressed: () {
                              setState(() {
                                selectedTime = '30 min';
                              });
                            },
                          ),
                          ClickableTime(
                            text: '60 min',
                            isSelected: selectedTime == '60 min',
                            onPressed: () {
                              setState(() {
                                selectedTime = '60 min';
                              });
                            },
                          ),
                          ClickableTime(
                            text: '2 hrs',
                            isSelected: selectedTime == '2 hrs',
                            onPressed: () {
                              setState(() {
                                selectedTime = '2 hrs';
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Working Hours",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    const ScheduleRow()
                  ],
                ),
                const SizedBox(height: 30),
                BlocBuilder<DoctorAvailabilityBloc, DoctorAvailabilityState>(
                  builder: (context, state) {
                    return Align(
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 0.9 * MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                          onPressed: () {
                            final availability =
                                <String, List<Map<String, String>>>{};

                            final schedules =
                                BlocProvider.of<ScheduleCubit>(context).state;

                            for (final schedule in schedules) {
                              final dayAbbreviated = schedule.day;
                              final dayFullName =
                                  dayFullNameMap[dayAbbreviated];
                              final start = schedule.startTime;
                              final end = schedule.endTime;
                              final isEnabled = schedule.isEnabled;
                              if (isEnabled) {
                                availability[dayFullName!] ??= [];
                                availability[dayFullName]!
                                    .add({'start': start, 'end': end});
                              }
                            }

                            // Print the availability in the desired format
                            // print('Availability: $availability');
                            context
                                .read<DoctorAvailabilityBloc>()
                                .add(AddDoctorAvailability(
                                  doctorId: 12,
                                  duration:
                                      int.parse(selectedTime.split(" ")[0]),
                                  availability: availability,
                                ));
                            // Navigator.pushNamed(context, route.charges);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff0154ba),
                            padding: const EdgeInsets.all(14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: state is DoctorAvailabilityLoading
                              ? CupertinoActivityIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Save',
                                  style: TextStyle(color: Colors.white),
                                ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
