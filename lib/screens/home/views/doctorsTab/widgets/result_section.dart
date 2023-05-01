import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../../../mock/service/get_doctor_service.dart';

class ResultSection extends StatelessWidget {
  const ResultSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
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
                        onPressed: () {}, child: const Text('See All')))
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: getDoctor.doctors
                  .take(2)
                  .map((doctor) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          //height: 200,
                          width: (size.width / 2) - 28,
                          decoration: BoxDecoration(
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(20)),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(8, 20, 8, 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                  child: Text(
                                    (doctor.name ?? ''),
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.titleLarge
                                        ?.copyWith(fontSize: 15),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                  child: Text(
                                    doctor.speciality ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: textTheme.titleLarge
                                        ?.copyWith(fontSize: 15),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: 20,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: 2, color: Colors.grey),
                                      borderRadius: BorderRadius.circular(12)),
                                  child: Center(
                                      child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: const [
                                        Icon(
                                          Icons.star,
                                          color: Colors.grey,
                                          size: 15,
                                        ),
                                        Text(
                                          '5.0',
                                          style: TextStyle(fontSize: 9),
                                        )
                                      ])),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                SvgPicture.asset(
                                  doctor.image!,
                                  height: 150,
                                )
                              ],
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
          ],
        ),
      );
    });
  }
}
