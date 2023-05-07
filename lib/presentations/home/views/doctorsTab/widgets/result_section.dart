import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../doctorsTab/views/all_results.dart';
import '/mock/service/get_doctor_service.dart';
import 'doctor_result_widget1.dart';

class ResultSection extends StatelessWidget {
  const ResultSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Consumer<GetDoctor>(builder: (context, getDoctor, _) {
      return Visibility(
        visible: getDoctor.resultReturned && getDoctor.doctors.isNotEmpty,
        replacement: Visibility(
          visible: getDoctor.resultReturned && getDoctor.doctors.isEmpty,
          child: SizedBox(
            height: 150,
            width: size.width,
            child: const Center(
              child: Text('No results found, try a different search Term'),
            ),
          ),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Align(
                    alignment: Alignment.centerLeft, child: Text('Results')),
                Visibility(
                    visible: getDoctor.doctors.length > 2,
                    child: TextButton(
                        onPressed: () => showModalBottomSheet(
                              barrierColor: Colors.transparent,
                              useSafeArea: true,
                              context: context,
                              isScrollControlled: true,
                              builder: (context) => const AllResults(),
                            ),
                        child: const Text('See All')))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: getDoctor.doctors
                  .take(2)
                  .map((doctor) => DoctorResultWidget1(
                        doctor: doctor,
                      ))
                  .toList(),
            ),
          ],
        ),
      );
    });
  }
}
