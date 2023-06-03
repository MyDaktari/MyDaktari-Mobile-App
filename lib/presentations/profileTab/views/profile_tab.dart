import 'package:flutter/material.dart';
import '../widgets/profile_summary.dart';

class ProfileTab extends StatelessWidget {
  ProfileTab({super.key});

  final List<Map<String, dynamic>> tools = [
    {
      'title': 'Take Your Meds',
      'route': '',
    },
    {
      'title': 'Screening and Procedures',
      'route': '',
    },
    {
      'title': 'Medical Support Team',
      'route': '',
    },
    {
      'title': 'Track Symptoms',
      'route': '',
    },
  ];
  final List<Map<String, dynamic>> saved = [
    {
      'title': 'Conditions',
      'image': 'assets/images/reminder.png',
    },
    {
      'title': 'Drugs',
      'image': 'assets/images/virus.png',
    },
    {
      'title': 'Articles',
      'image': 'assets/images/graph-report.png',
    },
  ];

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        ProfileSummary(),
        Expanded(
          child: ListView(
            children: [
              const SizedBox(height: 15),
              Center(
                child: Text('Tools',
                    style: textTheme.titleLarge?.copyWith(fontSize: 15)),
              ),
              const SizedBox(height: 15),
              const Divider(),
              SizedBox(
                height: 190,
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Center(
                      child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(tools[index]['title']))),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: tools.length,
                ),
              ),
              const Divider(),
              const SizedBox(
                height: 15,
              ),
              Center(
                  child: Text('Saved',
                      style: textTheme.titleLarge?.copyWith(fontSize: 15))),
              const SizedBox(height: 15),
              const Divider(),
              SizedBox(
                height: 190,
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Image.asset(saved[index]['image'], height: 20),
                        Text(saved[index]['title'])
                      ],
                    ),
                  )),
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: saved.length,
                ),
              ),
              const Divider(),
            ],
          ),
        ),
      ],
    );
  }
}
