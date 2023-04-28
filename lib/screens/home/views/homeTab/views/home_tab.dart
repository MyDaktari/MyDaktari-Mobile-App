import 'package:flutter/material.dart';

class HomeTabView extends StatelessWidget {
  HomeTabView({super.key});
  final List<Map<String, dynamic>> grids = [
    {'image': 'assets/reminder.png', 'title': 'reminder', 'route': ''},
    {'image': 'assets/reminder.png', 'title': 'Symptom Checker', 'route': ''},
    {'image': 'assets/virus.png', 'title': 'Allergy Tracker', 'route': ''},
    {
      'image': 'assets/graph-report.png',
      'title': 'Track Symptoms',
      'route': ''
    },
    {
      'image': 'assets/pharmacist.png',
      'title': 'Prescription Discounts',
      'route': ''
    },
    {'image': 'assets/engage.png', 'title': 'Drug Interactions', 'route': ''},
  ];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Column(
        children: [
          Container(
            height: size.height * .18,
            decoration:
                const BoxDecoration(color: Color.fromARGB(255, 242, 242, 242)),
            child: Padding(
              padding: const EdgeInsets.only(left: 28.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Talk to Aya,',
                        style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 1, 84, 186)),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        'Your virtual assistant.',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Color.fromARGB(255, 0, 236, 182)),
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(21)),
                              backgroundColor:
                                  const Color.fromARGB(255, 0, 236, 182)),
                          onPressed: () {},
                          child: const Text('Get Started'))
                    ],
                  ),
                  Image.asset('assets/aya-half.png')
                ],
              ),
            ),
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
                  return Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey, width: .5)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(
                          grid['image'],
                          height: 30,
                        ),
                        Text(grid['title'])
                      ],
                    ),
                  );
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
