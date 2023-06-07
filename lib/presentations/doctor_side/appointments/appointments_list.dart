import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/constants/routes/route.dart' as route;
import 'package:my_daktari/logic/bloc/auth_status/auth_status_bloc.dart';

import 'appointment_card.dart';

class AppointmentTab extends StatelessWidget {
  const AppointmentTab({super.key, required this.list});
  final List list;
  @override
  Widget build(BuildContext context) {
    return list.isNotEmpty
        ? ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return DoctorAppointmentCard(
                  doctorAppointment: list.elementAt(index));
            })
        : Center(
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('You\'ve got nothing yet'),
              SizedBox(height: 20),
              // ElevatedButton(
              //   onPressed: () async {
              //     Navigator.pushReplacementNamed(context, route.personalInfo);
              //   },
              //   style: ElevatedButton.styleFrom(backgroundColor: primaryColor),
              //   child: Text('Complete your profile'),
              // ),
              SizedBox(height: 20),
              BlocBuilder<AuthStatusBloc, AuthStatusState>(
                builder: (context, state) {
                  if (state is UserAuthenticated) {
                    return Visibility(
                      visible: !state.fullProfileCompleted,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, route.schedule);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: primaryColor),
                        child: Text('Manage Appointments'),
                      ),
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              )
            ],
          ));
  }
}
