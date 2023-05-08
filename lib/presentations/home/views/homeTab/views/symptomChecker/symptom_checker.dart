import 'package:flutter/material.dart';
import 'package:my_daktari/mock/models/symptom_model.dart';
import 'package:my_daktari/mock/symptoms/symptoms.dart';
import 'package:my_daktari/constants/constants.dart' as constants;

class SymptomChecker extends StatelessWidget {
  SymptomChecker({super.key});

  final List<SymptomModel> _symptoms =
      symptoms.map((json) => SymptomModel.fromJson(json)).toList();
  final ActiveSymptom _activeSymptom = ActiveSymptom(null);
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ValueListenableBuilder(
        valueListenable: _activeSymptom,
        builder: (context, value, _) {
          return Scaffold(
            appBar: AppBar(),
            body: ListView(
              children: _symptoms
                  .map((symptoms) => Padding(
                        padding: EdgeInsets.all(size.width * .01),
                        child: SizedBox(
                          width: size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                symptoms.title!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Wrap(
                                alignment: WrapAlignment.start,
                                runSpacing: 10,
                                spacing: 10,
                                children: symptoms.symptoms!
                                    .map((symptom) => InkWell(
                                          onTap: () {
                                            _activeSymptom.activeSymptom =
                                                symptom;
                                          },
                                          child: SizedBox(
                                            width: size.width * .95 / 2,
                                            child: Stack(
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    const Divider(
                                                      thickness: 2,
                                                      color: constants
                                                          .primaryColor,
                                                    ),
                                                    Text(
                                                      symptom.symptom!,
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: constants
                                                              .primaryColor),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Text(symptom.description!)
                                                  ],
                                                ),
                                                Visibility(
                                                  visible: value == symptom,
                                                  child: Align(
                                                    alignment:
                                                        Alignment.topRight,
                                                    child: Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration:
                                                          const BoxDecoration(
                                                              color: constants
                                                                  .primaryColor,
                                                              shape: BoxShape
                                                                  .circle),
                                                      child: const Icon(
                                                        Icons.check,
                                                        color: Colors.white,
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
          );
        });
  }
}

class ActiveSymptom extends ValueNotifier<Symptoms?> {
  ActiveSymptom(Symptoms? value) : super(value);

  set activeSymptom(Symptoms symptom) {
    value = symptom;
    notifyListeners();
  }
}
