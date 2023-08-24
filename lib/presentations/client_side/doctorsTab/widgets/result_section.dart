import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/presentations/widgets/custom_loading.dart';

import '../../../../logic/bloc/client_bloc/search_doctor/search_doctor_bloc.dart';
import '../../homeTab/views/symptomChecker/doctor_by_symptoms_screen.dart';
import 'doctor_result_widget1.dart';

class ResultSection extends StatelessWidget {
  const ResultSection({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return BlocBuilder<SearchDoctorBloc, SearchDoctorState>(
      builder: (context, state) {
        if (state is SearchDoctorLoading) {
          return Center(child: CustomLoading());
        } else if (state is SearchDoctorLoaded) {
          return Visibility(
            visible: state.doctors.isNotEmpty,
            replacement: Visibility(
              visible: state.doctors.isEmpty,
              child: SizedBox(
                height: 150,
                width: size.width,
                child: const Center(
                    child:
                        Text('No results found, try a different search Term')),
              ),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Align(
                        alignment: Alignment.centerLeft,
                        child: Text('Results')),
                    Visibility(
                        visible: state.doctors.length > 2,
                        child: TextButton(
                            onPressed: () => showModalBottomSheet(
                                  barrierColor: Colors.transparent,
                                  useSafeArea: true,
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) =>
                                      const DoctorBySymptomsScreen(),
                                ),
                            child: const Text('See All')))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: state.doctors
                      .take(2)
                      .map((doctor) => DoctorResultWidget1(doctor: doctor))
                      .toList(),
                ),
              ],
            ),
          );
        } else if (state is SearchDoctorInitialized) {
          return SizedBox();
        } else if (state is SearchDoctorLoadingError) {
          return Center(child: Text(state.errorMessage));
        } else {
          return Text('Something went wrong');
        }
      },
    );
  }
}
