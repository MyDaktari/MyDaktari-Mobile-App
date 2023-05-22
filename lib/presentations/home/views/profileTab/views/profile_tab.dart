import 'package:flutter/material.dart';
import 'package:my_daktari/mock/models/doctor_model.dart';
import 'package:my_daktari/models/client.dart';
import 'package:provider/provider.dart';

import '../../../../../services/auth_page_provider.dart';
import '../../../widgets/tab_header_bar.dart';
import '/constants/constants.dart' as constants;
import '/routes/app_route.dart' as routes;

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
          child: Consumer<AuthPageProvider>(builder: (context, auth, _) {
            if (auth.user != null) {
              return Container(
                height: size.height * .18,
                width: size.width,
                decoration: const BoxDecoration(color: constants.primaryColor),
                child: Padding(
                  padding: const EdgeInsets.only(left: 28.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Text(
                                ((auth.userType?.name.contains('client') ??
                                            false)
                                        ? (auth.user as ClientModel).name
                                        : (auth.user as DoctorModel).name) ??
                                    '',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                            const SizedBox(height: 10),
                            Text(auth.user?.email ?? '',
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 12)),
                            ElevatedButton(
                                onPressed: () {
                                  auth.signOut();
                                },
                                child: const Text('Sign Out'))
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 2,
                          child: Image.asset('assets/images/male-user.png'))
                    ],
                  ),
                ),
              );
            }
            return TabHeader(
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
                    Navigator.pushNamed(context, routes.loginScreen);
                  },
                  child: const Text('Sign In')),
              image: Image.asset('assets/images/telehealth.png'),
            );
          }),
        ),
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
