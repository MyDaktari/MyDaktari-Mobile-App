import 'package:flutter/material.dart';
import 'package:my_daktari/mock/models/symptom_model.dart';
import 'package:my_daktari/mock/symptoms/symptoms.dart';
import 'package:my_daktari/constants/constants.dart' as constants;
import 'package:provider/provider.dart';

import '../../../../../mock/service/get_doctor_service.dart';
import '../../../doctorsTab/views/all_results.dart';
import 'symptom_checker.dart';

class SymptomSamples extends StatelessWidget {
  SymptomSamples({super.key, required this.bodyPartNotifier});
  final BodyPartNotifier bodyPartNotifier;
  final List<SymptomModel> _symptoms =
      symptoms.map((json) => SymptomModel.fromJson(json)).toList();
  final ActiveSymptom _activeSymptom = ActiveSymptom([]);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ValueListenableBuilder(
        valueListenable: bodyPartNotifier,
        builder: (context, _bodyPart, _) {
          return ValueListenableBuilder(
              valueListenable: _activeSymptom,
              builder: (context, value, _) {
                return Scaffold(
                  appBar: AppBar(
                    title: Text('Symptoms'),
                  ),
                  body: Column(
                    children: [
                      Expanded(
                        child: ListView(
                          children: (_bodyPart != null
                                  ? !_bodyPart.bodyPart!
                                          .toLowerCase()
                                          .contains('not sure')
                                      ? _symptoms.where((x) =>
                                          x.bodyPart == _bodyPart.bodyPart)
                                      : _symptoms
                                  : _symptoms)
                              .map((symptoms) => Padding(
                                    padding: EdgeInsets.all(size.width * .01),
                                    child: SizedBox(
                                      width: size.width,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            symptoms.bodyPart!,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18),
                                          ),
                                          Wrap(
                                            alignment: WrapAlignment.start,
                                            runSpacing: 10,
                                            spacing: 10,
                                            children: symptoms.symptoms!
                                                .map((symptom) => InkWell(
                                                      onTap: () {
                                                        _activeSymptom
                                                            .addSymtom(symptom);
                                                      },
                                                      child: SizedBox(
                                                        width: size.width *
                                                            .95 /
                                                            2,
                                                        child: Stack(
                                                          children: [
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                const Divider(
                                                                  thickness: 2,
                                                                  color: constants
                                                                      .primaryColor,
                                                                ),
                                                                Text(
                                                                  symptom
                                                                      .symptom!,
                                                                  style: const TextStyle(
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: constants
                                                                          .primaryColor),
                                                                ),
                                                                const SizedBox(
                                                                  height: 5,
                                                                ),
                                                                Text(symptom
                                                                    .description!)
                                                              ],
                                                            ),
                                                            Visibility(
                                                              visible: value
                                                                  .contains(
                                                                      symptom),
                                                              child: Align(
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                child:
                                                                    Container(
                                                                  height: 40,
                                                                  width: 40,
                                                                  decoration: const BoxDecoration(
                                                                      color: constants
                                                                          .primaryColor,
                                                                      shape: BoxShape
                                                                          .circle),
                                                                  child:
                                                                      const Icon(
                                                                    Icons.check,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                          )
                                        ],
                                      ),
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                      Consumer<GetDoctor>(builder: (context, getDoctor, _) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: constants.primaryColor),
                              onPressed: value.isEmpty
                                  ? null
                                  : () {
                                      getDoctor.search('dr');
                                      showModalBottomSheet(
                                        barrierColor: Colors.transparent,
                                        useSafeArea: true,
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (context) =>
                                            const AllResults(),
                                      );
                                    },
                              child: Text('Continue')),
                        );
                      })
                    ],
                  ),
                );
              });
        });
  }
}

class ActiveSymptom extends ValueNotifier<List<Symptoms?>> {
  ActiveSymptom(List<Symptoms> value) : super(value);

  void addSymtom(Symptoms symptom) {
    value.contains(symptom) ? value.remove(symptom) : value.add(symptom);
    notifyListeners();
  }
}
