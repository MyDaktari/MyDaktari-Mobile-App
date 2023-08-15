import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/logic/bloc/auth_status/auth_status_bloc.dart';
import 'package:my_daktari/logic/bloc/client_bloc/doctors_symptom/doctors_symptom_bloc.dart';
import 'package:my_daktari/logic/cubit/booking_info/booking_info_cubit.dart';
import 'package:my_daktari/presentations/client_side/homeTab/widgets/authentication_dialog.dart';

import '../../../../../constants/colors.dart';
import '../../../../../logic/bloc/client_bloc/symptoms_bloc/symptoms_bloc.dart';
import '../../../../../logic/cubit/symptoms/symptoms_cubit_cubit.dart';
import '../../../../../models/symptom_model.dart';
import '../../../../widgets/custom_loading.dart';
import 'package:my_daktari/constants/route.dart' as route;
import 'symptom_checker_Screen.dart';

class SymptomSamples extends StatefulWidget {
  SymptomSamples({required this.bodyPartNotifier});

  final BodyPartNotifier bodyPartNotifier;

  @override
  State<SymptomSamples> createState() => _SymptomSamplesState();
}

class _SymptomSamplesState extends State<SymptomSamples> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final selectedSymptoms = context.read<SymptomsCubit>();
    return Scaffold(
      appBar: AppBar(title: Text('Symptoms')),
      body: BlocBuilder<SymptomsBloc, SymptomsState>(
        builder: (context, state) {
          if (state is SymptomsLoading) {
            return CustomLoading();
          } else if (state is SymptomsLoadingError) {
            return Center(child: Text(state.message));
          } else if (state is SymptomsLoaded) {
            final List<SymptomModel> symptoms = state.symptoms;
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ScrollConfiguration(
                behavior: ScrollBehavior(),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Text('Click on one or more of the options',
                          style: TextStyle()),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 1),
                        height: MediaQuery.of(context).size.height * .75,
                        child: ListView.builder(
                          itemCount: symptoms.length,
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 10),
                                Center(
                                  child: Text(
                                      symptoms[index].bodyPart as String,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                                SizedBox(height: 10),
                                Wrap(
                                  alignment: WrapAlignment.spaceBetween,
                                  children:
                                      symptoms[index].symptoms!.map((symptom) {
                                    final isSelected = context
                                        .read<SymptomsCubit>()
                                        .selected(symptom);
                                    return Container(
                                      width: size.width * .48,
                                      height: size.height * .2,
                                      child: GestureDetector(
                                        onTap: () {
                                          selectedSymptoms.addSymptoms(symptom);
                                          setState(() {});
                                        },
                                        child: Card(
                                          shadowColor: AppColor.primaryColor,
                                          child: Padding(
                                            padding: const EdgeInsets.all(10.0),
                                            child: Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Expanded(
                                                      child: Text(
                                                          symptom.symptom ??
                                                              "No title",
                                                          style: TextStyle(
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                              fontSize: 14,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w700,
                                                              color: AppColor
                                                                  .primaryColor)),
                                                    ),
                                                    isSelected
                                                        ? Icon(
                                                            Icons.check_circle,
                                                            color: AppColor
                                                                .primaryColor)
                                                        : Icon(
                                                            Icons
                                                                .check_circle_outline,
                                                            color: Colors.grey)
                                                  ],
                                                ),
                                                SizedBox(height: 5),
                                                Text(
                                                  symptom.description ??
                                                      "No description",
                                                  textAlign: TextAlign.left,
                                                  maxLines: 5,
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyLarge!
                                                      .copyWith(
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                )
                              ],
                            );
                          },
                        ),
                      ),
                      BlocBuilder<SymptomsBloc, SymptomsState>(
                        builder: (context, state) {
                          if (state is SymptomsLoaded) {
                            final selectedSymptoms = context
                                .read<SymptomsCubit>()
                                .state
                                .selectedSymptoms;
                            return BlocBuilder<AuthStatusBloc, AuthStatusState>(
                              builder: (context, state) {
                                return state is UserAuthenticated
                                    ? Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColor.primaryColor,
                                              fixedSize:
                                                  Size(size.width * .8, 50)),
                                          onPressed: selectedSymptoms.isEmpty
                                              ? null
                                              : () {
                                                  context
                                                      .read<BookingInfoCubit>()
                                                      .updateBookingInfo(
                                                          symptomID:
                                                              selectedSymptoms
                                                                  .first
                                                                  .symptomID
                                                                  .toString());
                                                  context
                                                      .read<
                                                          DoctorsBySymptomsBloc>()
                                                      .add(SearchDoctorsBySymptoms(
                                                          symptomId:
                                                              selectedSymptoms
                                                                  .first
                                                                  .symptomID
                                                                  .toString(),
                                                          context: context));
                                                  //clear it here
                                                  context
                                                      .read<SymptomsCubit>()
                                                      .clearSelectedSymptoms();
                                                  Navigator.pushNamed(
                                                      context,
                                                      route
                                                          .doctorBySymptomsScreen);
                                                },
                                          child: Text('Continue'),
                                        ),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppColor.primaryColor,
                                            fixedSize:
                                                Size(size.width * .8, 50),
                                          ),
                                          onPressed: selectedSymptoms.isEmpty
                                              ? null
                                              : () {
                                                  loginDialog(context);
                                                },
                                          child: Text('Continue'),
                                        ),
                                      );
                              },
                            );
                          } else if (state is SymptomsLoading) {
                            return CustomLoading();
                          } else if (state is SymptomsLoadingError) {
                            return Center(child: Text(state.message));
                          } else {
                            return Center(
                                child: Text('Could not load symptoms'));
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Center(child: Text('An unknown error'));
          }
        },
      ),
    );
  }
}

// symptom.symptoms!
//                                           .map((s) => InkWell(
//                                                 onTap: () {
//                                                   BlocProvider.of<SymptomsBloc>(
//                                                           context)
//                                                       .add(SelectSymptom(
//                                                           symptom: s));
//                                                 },
//                                                 child: SizedBox(
//                                                   width: size.width * .95 / 2,
//                                                   child: Padding(
//                                                     padding:
//                                                         const EdgeInsets.all(
//                                                             5.0),
//                                                     child: Stack(
//                                                       children: [
//                                                         Column(
//                                                           crossAxisAlignment:
//                                                               CrossAxisAlignment
//                                                                   .start,
//                                                           children: [
//                                                             const Divider(
//                                                               thickness: 2,
//                                                               color: constants
//                                                                   .primaryColor,
//                                                             ),
//                                                             Text(
//                                                               s.symptom!,
//                                                               style:
//                                                                   const TextStyle(
//                                                                 fontWeight:
//                                                                     FontWeight
//                                                                         .bold,
//                                                                 color: constants
//                                                                     .primaryColor,
//                                                               ),
//                                                             ),
//                                                             const SizedBox(
//                                                               height: 5,
//                                                             ),
//                                                             Text(
//                                                                 s.description!),
//                                                           ],
//                                                         ),
//                                                         BlocBuilder<
//                                                             SymptomsBloc,
//                                                             SymptomsState>(
//                                                           builder:
//                                                               (context, state) {
//                                                             if (state
//                                                                 is SymptomsLoaded) {
//                                                               final selectedSymptoms =
//                                                                   state
//                                                                       .selectedSymptoms;
//                                                               final isSelected =
//                                                                   selectedSymptoms
//                                                                       .contains(
//                                                                           s.symptomID);
//
//                                                             } else {
//                                                               return SizedBox();
//                                                             }
//                                                           },
//                                                         ),
//                                                       ],
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ))
//                                           .toList(),
