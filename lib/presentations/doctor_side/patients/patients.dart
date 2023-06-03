import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/presentations/doctor_side/patients/patient_card.dart';

import '../../../logic/bloc/doctor_bloc/doctor_patients/doctor_patients_bloc.dart';

class PatientsTab extends StatelessWidget {
  const PatientsTab({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Patients',
            style: textTheme.titleLarge,
          ),
          Expanded(
            child: BlocBuilder<DoctorPatientsBloc, DoctorPatientsState>(
              builder: (context, state) {
                if (state is DoctorPatientsLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is DoctorPatientsLoaded) {
                  return ListView.builder(
                      itemCount: state.patients.length,
                      itemBuilder: (context, index) {
                        return DoctorPatientCard(
                            patient: state.patients.elementAt(index));
                      });
                } else if (state is DoctorPatientsLoadingError) {
                  return Center(child: Text(state.message));
                } else {
                  return Center(child: Text('We could not load your patients'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
