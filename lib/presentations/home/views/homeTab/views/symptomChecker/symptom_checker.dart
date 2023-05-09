import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/mock/models/symptom_model.dart';
import 'package:my_daktari/mock/symptoms/symptoms.dart' as s;
import 'package:my_daktari/routes/app_route.dart' as routes;

class SymptomChecker extends StatelessWidget {
  SymptomChecker({super.key});
  final List<SymptomModel> _symptoms = s.symptoms
      .map((symptom) => SymptomModel.fromJson(symptom))
      .toList()
    ..add(SymptomModel(bodyPart: 'Not Sure'));
  final BodyPartNotifier _bodyPartNotifier = BodyPartNotifier(null);
  final TextEditingController _symptomsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: _bodyPartNotifier,
        builder: (context, _symptom, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Report Symptoms'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  DropdownButtonFormField<SymptomModel>(
                    style: TextStyle(color: Colors.grey),
                    value: _symptom,
                    onChanged: (SymptomModel? newValue) {
                      _bodyPartNotifier.selectedSymmptom = newValue;
                    },
                    items: _symptoms.map((SymptomModel option) {
                      return DropdownMenuItem<SymptomModel>(
                        value: option,
                        child: Text(option.bodyPart!),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                        labelText: 'Most affected body part',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: 100,
                    ),
                    child: TextField(
                      controller: _symptomsController,
                      style: TextStyle(color: Colors.grey),
                      maxLines: null, // allow unlimited number of lines
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        labelText:
                            'Describe your Symptoms, (be as precise as possible)',
                        hintText: 'Describe your symptoms here',
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor),
                      onPressed: () => Navigator.pushNamed(
                          context, routes.symptomSamples,
                          arguments: _bodyPartNotifier),
                      child: Text('Continue')),
                  const SizedBox(
                    height: 15,
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: 'Not sure What to say? ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'Check out our sample symptoms.',
                          style: TextStyle(color: primaryColor),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.pushNamed(
                                  context, routes.symptomSamples,
                                  arguments: BodyPartNotifier(
                                      SymptomModel(bodyPart: 'Not sure')));
                            },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class BodyPartNotifier extends ValueNotifier<SymptomModel?> {
  BodyPartNotifier(SymptomModel? value) : super(value);
  set selectedSymmptom(SymptomModel? symptom) {
    value = symptom;
    notifyListeners();
  }
}
