import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/doctor_result_widget2.dart';
import '/mock/service/get_doctor_service.dart';

class AllResults extends StatelessWidget {
  const AllResults({super.key});

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Consumer<GetDoctor>(builder: (context, getDoctor, _) {
      return Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            topRight: Radius.circular(25.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () => Navigator.pop(context),
                      icon: const Icon(Icons.arrow_back)),
                  Text(
                    'Doctors',
                    style: textTheme.titleLarge?.copyWith(fontSize: 18),
                  ),
                  TextButton(onPressed: () {}, child: const Text('Filter'))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: getDoctor.doctors.length,
                  itemBuilder: (context, index) {
                    final doctor = getDoctor.doctors[index];
                    return DoctorResultWidget2(doctor: doctor);
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    height: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
