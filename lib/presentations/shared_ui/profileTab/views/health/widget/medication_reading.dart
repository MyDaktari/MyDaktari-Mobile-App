import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../constants/constants.dart';
import '../../../../../../constants/route.dart' as route;
import '../../../../../../constants/colors.dart';
import '../../../../../../logic/bloc/shared_bloc/medication/medication_bloc.dart';

class MedicationReadingCard extends StatelessWidget {
  const MedicationReadingCard({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<MedicationBloc>().add(LoadMedicationRecord(userId: userId));
    return GestureDetector(
      onTap: () =>
          //Fluttertoast.showToast(msg: 'Coming Soon!'),
          Navigator.pushNamed(context, route.medicationScreen),
      child: Card(
        child: Container(
          height: 100,
          alignment: Alignment.center,
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(Icons.medical_information,
                      size: 30.0, color: AppColor.primaryColor),
                  Text(' Medication',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold))
                ],
              ),
              Text('Dairy', style: TextStyle(fontSize: 18))
            ],
          ),
        ),
      ),
    );
  }
}
