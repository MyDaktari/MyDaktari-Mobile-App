import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/logic/bloc/client_bloc/client_appointment/client_appointments_bloc.dart';
import 'package:my_daktari/presentations/widgets/custom_loading.dart';

import 'client_appointment_card.dart';

class ClientAppointmentsScreen extends StatelessWidget {
  const ClientAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Appointments'), elevation: 0),
      body: BlocBuilder<ClientAppointmentsBloc, ClientAppointmentsState>(
        builder: (context, state) {
          if (state is ClientAppointmentsLoading) {
            return Center(child: CustomLoading());
          } else if (state is ClientAppointmentsLoaded) {
            return state.clientAppointments.isEmpty
                ? Center(child: Text('You have no appointment at the moment'))
                : ListView.builder(
                    itemCount: state.clientAppointments.length,
                    itemBuilder: (context, index) {
                      return ClientAppointmentCard(
                          clientAppointment:
                              state.clientAppointments.elementAt(index));
                    });
          } else if (state is ClientAppointmentsLoadError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    state.message,
                    textAlign: TextAlign.center,
                  ),
                  IconButton(
                      onPressed: () {
                        context
                            .read<ClientAppointmentsBloc>()
                            .add(LoadClientAppointments(cleintId: userId));
                      },
                      icon: Icon(Icons.refresh, size: 30))
                ],
              ),
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
