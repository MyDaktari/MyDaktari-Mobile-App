import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_daktari/constants/route.dart' as route;
import 'package:my_daktari/logic/bloc/auth_status/auth_status_bloc.dart';
import '../../../constants/colors.dart';
import 'appointment_card.dart';

class AppointmentTab extends StatelessWidget {
  const AppointmentTab({super.key, required this.list});
  final List list;
  @override
  Widget build(BuildContext context) {
    // print('hello');
    // print(context.read<WelcomeMessageCubit>().state.showMessage);
    // if (context.read<WelcomeMessageCubit>().state.showMessage) {
    //   welcomeDialog(
    //       context: context, message: doctorWelcomeMessage, title: 'My Dactary');
    // }
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
              BlocBuilder<AuthStatusBloc, AuthStatusState>(
                builder: (context, state) {
                  if (state is UserAuthenticated) {
                    if (!state.fullProfileCompleted) {
                      // if (context.mounted) {
                      //   welcomeDialog(
                      //       context: context,
                      //       message: doctorWelcomeMessage,
                      //       title: 'My Datatari');
                      // }
                    }
                    return Visibility(
                      visible: !state.fullProfileCompleted,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, route.schedule);
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColor.primaryColor),
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
