import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/models/appointment.dart';
import 'package:my_daktari/presentations/home/views/appointments/doctor_appointment_card.dart';

import '../../../../logic/bloc/doctor_bloc/doctor_appointments/doctor_appointments_bloc.dart';

class PatientAppointment extends StatelessWidget {
  PatientAppointment({super.key});
  final TabNotifier _tabNotifier = TabNotifier(0);
  final PageController _pageController = PageController();
  List<Widget> tabs(int tabValue) {
    List<String> titles = ['Today', 'Upcoming', 'Pending', 'History'];
    return titles.map((title) {
      int index = titles.indexOf(title);
      return tab(title, index, tabValue);
    }).toList();
  }

  Widget tab(String title, int index, int tabValue) {
    return GestureDetector(
      onTap: () {
        _tabNotifier.newValue = index;
        _pageController.animateToPage(index,
            duration: Duration(milliseconds: 200), curve: Curves.linear);
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: tabValue == index ? primaryColor : Colors.grey,
            ),
          ),
          SizedBox(
            height: 5,
          ),
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
    TextTheme textTheme = Theme.of(context).textTheme;
    return ValueListenableBuilder(
        valueListenable: _tabNotifier,
        builder: (context, tabValue, _) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Appointments',
                  style: textTheme.titleLarge,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'You have the following appointments',
                    style: textTheme.bodyMedium?.copyWith(fontSize: 21),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: tabs(tabValue)
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
                      return Center(child: CircularProgressIndicator());
                    } else if (state is DoctorAppointmentsLoaded) {
                      return Expanded(
                          child: PageView(
                        controller: _pageController,
                        onPageChanged: (val) {
                          _tabNotifier.newValue = val;
                        },
                        children: [
                          AppointmentList(list: []),
                          AppointmentList(list: []),
                          AppointmentList(
                              list: state.appointments
                                  .where((element) =>
                                      (element.appointmentStatus ?? '')
                                          .toLowerCase() ==
                                      'pending')
                                  .toList()),
                          AppointmentList(
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
        });
  }
}

class AppointmentList extends StatelessWidget {
  const AppointmentList({
    super.key,
    required this.list,
  });
  final List list;
  @override
  Widget build(BuildContext context) {
    return list.isNotEmpty
        ? ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return DoctorAppointmentCard(
                doctorAppointment: list.elementAt(index),
              );
            })
        : Center(
            child: Text('You\'ve got nothing yet'),
          );
  }
}

class TabNotifier extends ValueNotifier<int> {
  TabNotifier(int value) : super(value);

  set newValue(int value) {
    this.value = value;
    notifyListeners();
  }
}
