import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/logic/bloc/client_bloc/doctors_symptom/doctors_symptom_bloc.dart';
import 'package:my_daktari/presentations/widgets/custom_loading.dart';

import '../../../doctorsTab/widgets/doctor_result_widget2.dart';

class DoctorBySymptomsScreen extends StatelessWidget {
  const DoctorBySymptomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Doctors')),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              BlocBuilder<DoctorsBySymptomsBloc, DoctorsBySymptomsState>(
                builder: (context, state) {
                  if (state is DoctorsBySymptomsLoading) {
                    return Center(child: CustomLoading());
                  } else if (state is DoctorsBySymptomsLoaded) {
                    return Expanded(
                      child: ListView.separated(
                          itemCount: state.doctors.length,
                          itemBuilder: (context, index) {
                            return DoctorResultWidget2(
                                doctor: state.doctors.elementAt(index));
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(height: 10)),
                    );
                  } else if (state is DoctorsBySymptomsLoadError) {
                    return Column(
                      children: [
                        Text(state.errorMessage),
                        IconButton(icon: Icon(Icons.refresh), onPressed: () {})
                      ],
                    );
                  } else {
                    return const SizedBox();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
