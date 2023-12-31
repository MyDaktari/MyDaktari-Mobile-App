import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/logic/bloc/shared_bloc/auth_status/auth_status_bloc.dart';
import 'package:my_daktari/logic/bloc/doctor_bloc/doctor_availability/doctor_availability_bloc.dart';
import 'package:my_daktari/presentations/doctor_side/schedule/widgets/clickable_times.dart';
import 'package:my_daktari/presentations/doctor_side/schedule/widgets/working_hours.dart';

import '../../../constants/colors.dart';
import '../../../constants/constants.dart';
import '../../../logic/cubit/doctor_schedules/doctor_schedule.dart';
import 'package:my_daktari/constants/route.dart' as route;

import '../../widgets/success_dialogue.dart';
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
    scheduleCubit = ScheduleCubit(schedulesConstant);
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
                      textAlign: TextAlign.center),
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
                      color: AppColor.primaryColor.withOpacity(0.05),
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
                              onPressed: () =>
                                  setState(() => selectedTime = '2 hrs')),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text("Working Hours",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    const SizedBox(height: 20),
                    SingleChildScrollView(child: ScheduleRow())
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
                              final Map<String, List<Map<String, String>>>
                                  availability =
                                  schedulesToAvailability(schedulesConstant);
                              int formattedSelectedTime =
                                  int.parse(selectedTime.split(" ")[0]);
                              context
                                  .read<DoctorAvailabilityBloc>()
                                  .add(AddDoctorAvailability(
                                    doctorId: int.parse(userId),
                                    duration: selectedTime.contains("hrs")
                                        ? formattedSelectedTime * 60
                                        : formattedSelectedTime,
                                    availability: availability,
                                  ));
                            },
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xff0154ba),
                                padding: const EdgeInsets.all(14),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            child: BlocConsumer<DoctorAvailabilityBloc,
                                DoctorAvailabilityState>(
                              listener: (context, state) {
                                if (state is DoctorAvailabilityLoaded) {
                                  Navigator.pushNamed(context, route.charges);
                                }
                                if (state is DoctorAvailabilityLoadingError) {
                                  successDialog(
                                      context: context,
                                      message: state.message,
                                      title: 'My Daktari');
                                }
                              },
                              builder: (context, state) {
                                if (state is DoctorAvailabilityLoading) {
                                  return CupertinoActivityIndicator(
                                      color: Colors.white);
                                } else {
                                  return BlocBuilder<AuthStatusBloc,
                                      AuthStatusState>(
                                    builder: (context, state) {
                                      if (state is UserAuthenticated) {
                                        return Text(
                                            state.fullProfileCompleted
                                                ? 'Update'
                                                : 'Save',
                                            style:
                                                TextStyle(color: Colors.white));
                                      } else {
                                        return const SizedBox();
                                      }
                                    },
                                  );
                                }
                              },
                            )),
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
