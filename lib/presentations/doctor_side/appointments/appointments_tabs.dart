import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/presentations/widgets/custom_loading.dart';

import '../../../logic/bloc/doctor_bloc/doctor_appointments/doctor_appointments_bloc.dart';
import '../../../logic/cubit/tab_update/tab_update_cubit.dart';
import 'appointments_list.dart';

class PatientAppointment extends StatelessWidget {
  PatientAppointment({super.key});
  final PageController _pageController = PageController();

  Widget tab(String title, int index, int tabValue, BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<TabUpdateCubit>().setTabValue(index);
        _pageController.animateToPage(index,
            duration: Duration(milliseconds: 200), curve: Curves.linear);
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: tabValue == index ? primaryColor : Colors.grey),
          ),
          SizedBox(height: 5),
          Container(
            height: 3,
            decoration: BoxDecoration(
                color: tabValue == index ? primaryColor : Colors.grey,
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(index == 0 ? 20 : 0),
                    right: Radius.circular(index == 3 ? 20 : 0))),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> tabs(int tabValue) {
      List<String> titles = ['Upcoming', 'Pending', 'Past'];
      return titles.map((title) {
        int index = titles.indexOf(title);
        return tab(title, index, tabValue, context);
      }).toList();
    }

    TextTheme textTheme = Theme.of(context).textTheme;
    return BlocBuilder<TabUpdateCubit, TabUpdateState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Appointments',
                      style: textTheme.bodyMedium?.copyWith(fontSize: 21),
                    ),
                    Text('See All',
                        style: TextStyle(
                            color: primaryColor, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: SizedBox(
                  height: 50,
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: tabs(state.tabValue)
                        .map((tab) => Expanded(
                              child: tab,
                            ))
                        .toList(),
                  ),
                ),
              ),
              BlocBuilder<DoctorAppointmentsBloc, DoctorAppointmentsState>(
                builder: (context, state) {
                  if (state is DoctorAppointmentsLoading) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [CustomLoading()],
                      ),
                    );
                  } else if (state is DoctorAppointmentsLoaded) {
                    return Expanded(
                        child: PageView(
                      controller: _pageController,
                      onPageChanged: (val) {
                        context.read<TabUpdateCubit>().setTabValue(val);
                      },
                      children: [
                        AppointmentTab(list: []),
                        AppointmentTab(
                            list: state.appointments
                                .where((element) =>
                                    (element.appointmentStatus ?? '')
                                        .toLowerCase() ==
                                    'pending')
                                .toList()),
                        AppointmentTab(
                            list: state.appointments
                                .where((element) =>
                                    (element.appointmentStatus ?? '')
                                        .toLowerCase() ==
                                    'done')
                                .toList()),
                      ],
                    ));
                  } else if (state is DoctorAppointmentsLoadingError) {
                    return Center(child: Text(state.message));
                  } else {
                    return Center(
                        child: Text(
                            'An error Occured which fetching your appointment'));
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }
}
