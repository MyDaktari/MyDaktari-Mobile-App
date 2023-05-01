import 'package:flutter/material.dart';
import 'package:my_daktari/mock/service/get_doctor_service.dart';
import 'package:provider/provider.dart';

class AllResults extends StatelessWidget {
  const AllResults({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
                    return Container(
                      height: 220,
                      width: size.width,
                      decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Image.asset(
                              'assets/images/male-user.png',
                              height: 90,
                            ),
                            Text(doctor.name ?? ''),
                            Text(
                              doctor.speciality ?? '',
                              style:
                                  textTheme.titleLarge?.copyWith(fontSize: 10),
                            ),
                            Text(
                                '${doctor.experienceYears?.toString() ?? ''} Years Experience | 12.7 Km'),
                            Text(doctor.institution ?? ''),
                            Container(
                              height: 20,
                              width: 40,
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(width: 2, color: Colors.grey),
                                  borderRadius: BorderRadius.circular(12)),
                              child: Center(
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: const [
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 15,
                                    ),
                                    Text(
                                      '5.0',
                                      style: TextStyle(fontSize: 9),
                                    )
                                  ])),
                            ),
                          ],
                        ),
                      ),
                    );
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
