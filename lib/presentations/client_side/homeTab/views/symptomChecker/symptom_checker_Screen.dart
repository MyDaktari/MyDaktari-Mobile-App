import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_daktari/constants/route.dart' as routes;
import 'package:my_daktari/logic/cubit/booking_info/booking_info_cubit.dart';

import '../../../../../constants/colors.dart';
import '../../../../../logic/bloc/client_bloc/bodyparts_bloc/body_parts_bloc.dart';
import '../../../../../logic/bloc/client_bloc/symptoms_bloc/symptoms_bloc.dart';

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
    //  context.read<BodyPartsBloc>().add(LoadBodyParts());
    Size size = MediaQuery.of(context).size;
    return ValueListenableBuilder(
        valueListenable: _bodyPartNotifier,
        builder: (context, _bodyPart, _) {
          return Scaffold(
            appBar: AppBar(title: Text('Report Symptoms')),
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
                                height: 200)),
                        SizedBox(height: size.height * .1),
                        DropdownButtonFormField<String>(
                          style: TextStyle(color: Colors.grey),
                          value: _bodyPart,
                          onChanged: (String? newValue) {
                            _bodyPartNotifier.selectedBodyPart = newValue;
                          },
                          items: _bodyParts.map((option) {
                            return DropdownMenuItem<String>(
                                value: option, child: Text(option));
                          }).toList(),
                          decoration: InputDecoration(
                              labelText: 'Most affected body part',
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20))),
                        ),
                        const SizedBox(height: 15),
                        ConstrainedBox(
                          constraints: BoxConstraints(maxHeight: 100),
                          child: TextField(
                            controller: _symptomsController,
                            style: TextStyle(color: Colors.grey),
                            onChanged: (value) => context
                                .read<BookingInfoCubit>()
                                .updateBookingInfo(description: value),
                            maxLines: null, // allow unlimited number of lines
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                labelText:
                                    'Describe your Symptoms, (be as precise as possible)',
                                hintText: 'Describe your symptoms here'),
                          ),
                        ),
                        const SizedBox(height: 15),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColor.primaryColor,
                              fixedSize: Size(size.width * .8, 50),
                            ),
                            onPressed: () {
                              if (_bodyPart != null &&
                                  _symptomsController.text.isNotEmpty) {
                                context.read<SymptomsBloc>().add(LoadSymptoms(
                                        query: {
                                          "bodyParts": _bodyPart,
                                          "symptoms":
                                              _symptomsController.text.trim()
                                        }));
                                Navigator.pushNamed(
                                    context, routes.symptomSamples,
                                    arguments: _bodyPartNotifier);
                              } else {
                                Fluttertoast.showToast(
                                    msg: 'All Field are required');
                              }
                            },
                            child: BlocListener<SymptomsBloc, SymptomsState>(
                                listener: (context, state) {
                                  if (state is SymptomsLoaded) {
                                    print(_bodyPartNotifier);
                                    // Fluttertoast.showToast(
                                    //     msg: 'Symptoms loaded successfully');
                                    Navigator.pushNamed(
                                        context, routes.symptomSamples,
                                        arguments: _bodyPartNotifier);
                                  }
                                },
                                child: Text('Continue'))),
                        const SizedBox(height: 15),
                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                  text: 'Not sure What to say? ',
                                  style: TextStyle(color: Colors.black)),
                              TextSpan(
                                text: 'Check out our sample symptoms.',
                                style: TextStyle(color: AppColor.primaryColor),
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
              } else if (bPState is BodyPartsLoadingError) {
                return Center(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(bPState.message),
                        SizedBox(height: 10),
                        ElevatedButton(
                            onPressed: () {
                              context
                                  .read<BodyPartsBloc>()
                                  .add(LoadBodyParts());
                            },
                            child: Text('Retry'))
                      ]),
                );
              } else {
                return SizedBox(
                  child: Center(child: Text('Loading...')),
                );
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
