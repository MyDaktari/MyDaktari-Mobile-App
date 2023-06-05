import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/logic/bloc/symptoms_bloc/symptoms_bloc.dart';
import 'package:my_daktari/constants/constants.dart' as constants;

import '../../../../../logic/cubit/symptoms/symptoms_cubit_cubit.dart';
import '../../../../../mock/models/symptom_model.dart';
import '../../../../widgets/custom_loading.dart';
import '../../../doctorsTab/views/all_results.dart';
import 'symptom_checker.dart';

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
            return Center(
              child: Text(state.message),
            );
          } else if (state is SymptomsLoaded) {
            final List<SymptomModel> symptoms = state.symptoms;
            return Column(
              children: [
                Container(
                  padding: EdgeInsets.all(14),
                  height: MediaQuery.of(context).size.height * .8,
                  child: ListView.builder(
                    itemCount: symptoms.length,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            symptoms[index].bodyPart as String,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Wrap(
                            children: symptoms[index].symptoms!.map((symptom) {
                              return Container(
                                width: (size.width) * .4,
                                height: 200,
                                child: GestureDetector(
                                  onTap: () {
                                    selectedSymptoms.addSymptoms(symptom);
                                    setState(() {});
                                  },
                                  child: Card(
                                    shadowColor: constants.primaryColor,
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                symptom.symptom ?? "No title",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color:
                                                        constants.primaryColor),
                                              ),
                                              context
                                                      .read<SymptomsCubit>()
                                                      .selected(symptom)
                                                  ? Icon(
                                                      Icons
                                                          .check_circle_outline,
                                                    )
                                                  : Icon(
                                                      Icons.check_circle,
                                                      color: constants
                                                          .primaryColor,
                                                    )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 30,
                                          ),
                                          Text(
                                            symptom.description ??
                                                "No description",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.w500),
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
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: constants.primaryColor,
                          ),
                          onPressed: () {
                            final selectedSymptoms = state.selectedSymptoms;
                            if (selectedSymptoms.isNotEmpty) {
                              // getDoctor.search('dr');
                              showModalBottomSheet(
                                barrierColor: Colors.transparent,
                                useSafeArea: true,
                                context: context,
                                isScrollControlled: true,
                                builder: (context) => const AllResults(),
                              );
                            }
                          },
                          child: Text('Continue'),
                        ),
                      );
                    } else if (state is SymptomsLoading) {
                      return Center(
                          child: CupertinoActivityIndicator(
                        radius: 30,
                      ));
                    } else if (state is SymptomsLoadingError) {
                      return Center(
                        child: Text(state.message),
                      );
                    } else {
                      return Center(
                        child: Text('Could not load symptoms'),
                      );
                    }
                  },
                ),
              ],
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
