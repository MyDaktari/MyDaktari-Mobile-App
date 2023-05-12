import 'package:flutter/material.dart';
import 'package:my_daktari/presentations/home/views/appointments/patient_appointments.dart';
import 'package:my_daktari/presentations/home/views/patients/patients.dart';
import 'package:provider/provider.dart';

import '../../../services/auth_page_provider.dart';
import '../widgets/disclaimer.dart';
import '/constants/constants.dart' as constants;
import '/routes/app_route.dart' as routes;
import 'ayaTab/views/aya_tab.dart';
import 'doctorsTab/views/doctors_tab.dart';
import 'homeTab/views/home_tab.dart';
import 'profileTab/views/profile_tab.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final PageNotifier _pageNotifier = PageNotifier(value: 0);
  final PageController _pageController = PageController(initialPage: 0);
  late final AuthPageProvider _authPageProvider;
  bool isClient() {
    UserType userType = _authPageProvider.userType ?? UserType.client;
    return userType == UserType.client;
  }

  Color color(int index) {
    return _pageNotifier.value == index ? constants.primaryColor : Colors.grey;
  }

  List<BottomNavigationBarItem> bottomNavigationBarItems() {
    return [
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/home.png',
            height: 24,
            color: color(0),
          ),
          label: isClient() ? 'Home' : 'Appointments'),
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/doctor.png',
            height: 24,
            color: color(1),
          ),
          label: isClient() ? 'Doctors' : 'My Patients'),
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/nurse.png',
            height: 24,
            color: color(2),
          ),
          label: 'Aya'),
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/male-user.png',
            height: 24,
            color: color(3),
          ),
          label: 'Profile')
    ];
  }

  @override
  Widget build(BuildContext context) {
    _authPageProvider = context.read<AuthPageProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //TODO:
      //!negate this to hide dialog on hot reload
      if (!context.mounted) {
        isClient()
            ? showDialog(
                context: context,
                builder: (context) => const DisclaimerDialog())
            : null;
      }
    });
    return ValueListenableBuilder(
        valueListenable: _pageNotifier,
        builder: (context, currentIndex, _) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: (currentIndex == 1 && isClient())
                  ? 0
                  : Theme.of(context).appBarTheme.toolbarHeight,
              elevation: 0,
              leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.menu_rounded,
                    size: 50,
                  )),
              title: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Builder(builder: (context) {
                  switch (currentIndex) {
                    case 0:
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Visibility(
                          visible: isClient(),
                          child: const TextField(
                            decoration: InputDecoration(
                                hintText:
                                    'Search symptoms, medication, news...',
                                hintStyle: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    letterSpacing: 1),
                                border: InputBorder.none,
                                filled: true,
                                fillColor: Color.fromARGB(255, 224, 224, 224)),
                          ),
                        ),
                      );
                    case 2:
                      return const Text('Aya');
                    case 3:
                      return const Text('Profile');
                    default:
                      return const SizedBox();
                  }
                }),
              ),
              actions: currentIndex == 3
                  ? [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextButton(
                            onPressed: () {
                              _authPageProvider.setRegister(false);
                              Navigator.pushReplacementNamed(
                                  context, routes.authPage);
                            },
                            child: _authPageProvider.user != null
                                ? const SizedBox()
                                : const Text(
                                    'Sign In',
                                    style: TextStyle(fontSize: 18),
                                  )),
                      )
                    ]
                  : [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.notifications,
                            size: 40,
                          ))
                    ],
            ),
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (page) => _pageNotifier.index = page,
              children: [
                Visibility(
                    visible: isClient(),
                    replacement: PatientAppointment(),
                    child: HomeTabView()),
                Visibility(
                    visible: isClient(),
                    replacement: PatientsTab(),
                    child: DoctorsTab()),
                const AyaTab(),
                ProfileTab()
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: currentIndex,
                onTap: (value) {
                  _pageNotifier.index = value;
                  _pageController.jumpToPage(value);
                },
                items: bottomNavigationBarItems()),
          );
        });
  }
}

class PageNotifier extends ValueNotifier<int> {
  PageNotifier({required int value}) : super(value);

  set index(int value) {
    this.value = value;
    notifyListeners();
  }
}
