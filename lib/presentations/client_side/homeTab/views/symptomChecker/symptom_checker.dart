import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/logic/bloc/bodyparts_bloc/body_parts_bloc.dart';
import 'package:my_daktari/logic/bloc/symptoms_bloc/symptoms_bloc.dart';
import 'package:my_daktari/constants/routes/route.dart' as routes;

class SymptomChecker extends StatelessWidget {
  SymptomChecker({super.key});
  // final List<SymptomModel> _symptoms = s.symptoms
  //     .map((symptom) => SymptomModel.fromJson(symptom))
  //     .toList()
  //   ..add(SymptomModel(bodyPart: 'Not Sure'));

  final BodyPartNotifier _bodyPartNotifier = BodyPartNotifier(null);
  final TextEditingController _symptomsController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ValueListenableBuilder(
        valueListenable: _bodyPartNotifier,
        builder: (context, _bodyPart, _) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Report Symptoms'),
            ),
            body: BlocBuilder<BodyPartsBloc, BodyPartsState>(
                builder: (context, bPState) {
              if (bPState is BodyPartsLoaded) {
                List<String> _bodyParts = bPState.bodyParts
                    .map((bodyPart) => bodyPart.bodyPart.toString())
                    .toList()
                  ..add('Not Sure');
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: size.width * .21),
                          child: Image.asset(
                              'assets/images/my_daktari_blue.png',
                              height: 200),
                        ),
                        SizedBox(height: size.height * .1),
                        DropdownButtonFormField<String>(
                          style: TextStyle(color: Colors.grey),
                          value: _bodyPart,
                          onChanged: (String? newValue) {
                            _bodyPartNotifier.selectedBodyPart = newValue;
                          },
                          items: _bodyParts.map((option) {
                            return DropdownMenuItem<String>(
                              value: option,
                              child: Text(option),
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
                            onPressed: () {
                              context.read<SymptomsBloc>().add(
                                      LoadSymptoms(query: {
                                    "bodyParts": _bodyPart,
                                    "symptoms": _symptomsController.text.trim()
                                  }));
                              Navigator.pushNamed(
                                  context, routes.symptomSamples,
                                  arguments: _bodyPartNotifier);
                            },
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
                                        arguments:
                                            BodyPartNotifier('Not sure'));
                                  },
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              } else {
                return SizedBox();
              }
            }),
          );
        });
  }
}

class BodyPartNotifier extends ValueNotifier<String?> {
  BodyPartNotifier(String? value) : super(value);
  set selectedBodyPart(String? bodyPart) {
    value = bodyPart;
    notifyListeners();
  }
}
