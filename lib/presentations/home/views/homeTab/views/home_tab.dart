import 'package:flutter/material.dart';

import '../../../widgets/tab_header_bar.dart';
import '../widgets/grid_item.dart';
import '/constants/constants.dart' as constants;

class HomeTabView extends StatelessWidget {
  HomeTabView({super.key});
  final List<Map<String, dynamic>> grids = [
    {'image': 'assets/images/reminder.png', 'title': 'reminder', 'route': ''},
    {
      'image': 'assets/images/reminder.png',
      'title': 'Symptom Checker',
      'route': 'symptomChecker'
    },
    {
      'image': 'assets/images/virus.png',
      'title': 'Allergy Tracker',
      'route': 'allergyTracker'
    },
    {
      'image': 'assets/images/graph-report.png',
      'title': 'Track Symptoms',
      'route': 'trackSymptoms'
    },
    {
      'image': 'assets/images/pharmacist.png',
      'title': 'Prescription Discounts',
      'route': 'prescriptionDiscounts'
    },
    {
      'image': 'assets/images/engage.png',
      'title': 'Drug Interactions',
      'route': 'drugInteractions'
    },
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          TabHeader(
            size: size,
            title: Text(
              'Talk to Aya,',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            subtitle: Text('Your virtual assistant.',
                style: Theme.of(context).textTheme.titleMedium),
            button: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(21)),
                    backgroundColor: constants.greenish),
                onPressed: () {},
                child: const Text('Get Started')),
            image: Image.asset('assets/images/aya-half.png'),
          ),
          SizedBox(
            height: size.height * .25,
            child: GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: grids.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 3, crossAxisCount: 2),
                itemBuilder: (context, index) {
                  Map<String, dynamic> grid = grids[index];
                  return HomeGridItem(grid: grid);
                }),
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Top News',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Expanded(
              child: ListView(
            children: List.generate(
                5,
                (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        child: SizedBox(
                          height: 250,
                          width: size.width,
                          child: Column(
                            children: [
                              Container(
                                height: 150,
                                decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(25),
                                        topRight: Radius.circular(25)),
                                    color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )),
          ))
        ],
      ),
    );
  }
}
