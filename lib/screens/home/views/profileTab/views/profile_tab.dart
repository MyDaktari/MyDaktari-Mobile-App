import 'package:flutter/material.dart';

import 'package:my_daktari/constants/constants.dart' as constants;

import 'package:my_daktari/routes/app_route.dart' as routes;
import 'package:provider/provider.dart';

import '../../../../auth/services/auth_page_provider.dart';
import '../../../widgets/tab_header_bar.dart';

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
    AuthPageProvider authPageProvider = context.read<AuthPageProvider>();
    Size size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: TabHeader(
            size: size,
            title: Text(
              'Create Your Profile,',
              style: textTheme.titleLarge?.copyWith(fontSize: 22),
            ),
            subtitle: Text('save your important information',
                style: textTheme.titleMedium?.copyWith(
                    color: Colors.black,
                    fontSize: 13,
                    fontWeight: FontWeight.normal)),
            button: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(21)),
                    backgroundColor: constants.greenish),
                onPressed: () {
                  authPageProvider.setRegister(true);
                  Navigator.pushReplacementNamed(context, routes.authPage);
                },
                child: const Text('Register')),
            image: Image.asset('assets/images/telehealth.png'),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              const SizedBox(
                height: 15,
              ),
              Center(
                child: Text(
                  'Tools',
                  style: textTheme.titleLarge?.copyWith(fontSize: 15),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              const Divider(),
              SizedBox(
                height: 190,
                child: ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) => Center(
                      child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(tools[index]['title']),
                  )),
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
                child: Text(
                  'Saved',
                  style: textTheme.titleLarge?.copyWith(fontSize: 15),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
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
                        Image.asset(
                          saved[index]['image'],
                          height: 20,
                        ),
                        Text(saved[index]['title']),
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
