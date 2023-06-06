import 'package:flutter/material.dart';
import 'package:my_daktari/models/models.dart';

import '../../../doctorsTab/widgets/doctor_result_widget2.dart';

class DoctorBySymptomsScreen extends StatelessWidget {
  const DoctorBySymptomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Doctors'),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              const SizedBox(height: 20),
              Expanded(
                child: ListView.separated(
                    itemCount: 2,
                    itemBuilder: (context, index) {
                      return DoctorResultWidget2(doctor: DoctorProfileModel());
                    },
                    separatorBuilder: (BuildContext context, int index) =>
                        const SizedBox(height: 10)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
