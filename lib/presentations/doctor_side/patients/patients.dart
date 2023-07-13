import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/presentations/doctor_side/patients/patient_card.dart';
import 'package:my_daktari/presentations/profileTab/widgets/profile_summary.dart';
import 'package:my_daktari/presentations/widgets/custom_loading.dart';

import '../../../logic/bloc/doctor_bloc/doctor_patients/doctor_patients_bloc.dart';

class PatientsTab extends StatelessWidget {
  const PatientsTab({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ProfileSummary(),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Patients', style: textTheme.titleLarge)),
        Expanded(
          child: BlocBuilder<DoctorPatientsBloc, DoctorPatientsState>(
            builder: (context, state) {
              if (state is DoctorPatientsLoading) {
                return Center(child: CustomLoading());
              } else if (state is DoctorPatientsLoaded) {
                return state.patients.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListView.builder(
                            itemCount: state.patients.length,
                            itemBuilder: (context, index) {
                              return DoctorPatientCard(
                                  patient: state.patients.elementAt(index));
                            }),
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('You got no patients yet'),
                            IconButton(
                                onPressed: () {
                                  context.read<DoctorPatientsBloc>().add(
                                      LoadDoctorPatients(
                                          doctorId: doctor.id.toString()));
                                },
                                icon: Icon(Icons.refresh))
                          ],
                        ),
                      );
              } else if (state is DoctorPatientsLoadingError) {
                return Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.message),
                    IconButton(
                        onPressed: () {
                          context.read<DoctorPatientsBloc>().add(
                              LoadDoctorPatients(
                                  doctorId: doctor.id.toString()));
                        },
                        icon: Icon(Icons.refresh))
                  ],
                ));
              } else {
                return Center(child: Text('We could not load your patients'));
              }
            },
          ),
        ),
      ],
    );
  }
}
