import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/constants/routes/route.dart' as route;
import 'package:my_daktari/logic/bloc/auth_status/auth_status_bloc.dart';
import 'package:my_daktari/presentations/widgets/welcome_dialogue.dart';

import '../../../models/doctor.dart';
import 'appointment_card.dart';

class AppointmentTab extends StatelessWidget {
  const AppointmentTab({super.key, required this.list});
  final List list;
  @override
  Widget build(BuildContext context2) {
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

const String doctorWelcomeMessage =
    "We're delighted to have you as part of our medical community. With My Daktari, you now have the power to streamline your practice, enhance patient care, and embrace the future of healthcare.\nOur intuitive platform allows you to effortlessly connect with your patients, access their medical records securely, schedule appointments with ease, and even provide remote consultations through our telehealth feature.\nHowever, we may encounter occasional bugs or functionality issues as we continue to refine and improve our platform. Rest assured, we are dedicated to delivering the best user experience possible, and our team is working diligently to address any issues that arise. We value your feedback and encourage you to reach out to our support team if you have any questions or encounter any challenges.\nThank you for your understanding and for partnering with us on our journey to improving patient outcomes and access to care.\nWishing you a successful and fulfilling experience with My Daktari.\nBest regards,\nThe Dream team,\nMy Daktari";
