import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/presentations/home/views/appointments/patient_appointments.dart';
import 'package:my_daktari/presentations/home/views/patients/patients.dart';

import '../../../logic/cubit/page_update/page_update_cubit.dart';
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
  // final PageNotifier _pageNotifier = PageNotifier(value: 0);
  final PageController _pageController = PageController(initialPage: 0);
  late final AuthPageProvider _authPageProvider;
  // Helper method to determine if the user is a client
  bool isClient() {
    UserType userType = _authPageProvider.userType ?? UserType.client;
    return userType == UserType.client;
  }

  @override
  Widget build(BuildContext context) {
    _authPageProvider = context.read<AuthPageProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Show a dialog if the user is a client and the widget is mounted
      if (!context.mounted) {
        isClient()
            ? showDialog(
                context: context,
                builder: (context) => const DisclaimerDialog())
            : null;
      }
    });
    return BlocBuilder<PageUpdateCubit, PageUpdateState>(
        builder: (context, state) {
      // Helper method to get the color based on the current page
      Color color(int index) =>
          state.index == index ? constants.primaryColor : Colors.grey;
      return Scaffold(
        appBar: AppBar(
          toolbarHeight: (state.index == 1 && isClient())
              ? 0
              : Theme.of(context).appBarTheme.toolbarHeight,
          elevation: 0,
          leading: SizedBox(),
          title: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Builder(builder: (context) {
              switch (state.index) {
                case 0:
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Visibility(
                      visible: isClient(),
                      child: const TextField(
                        decoration: InputDecoration(
                            hintText: 'Search symptoms, medication, news...',
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
          actions: state == 3
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
                            : const Text('Sign In',
                                style: TextStyle(fontSize: 18))),
                  )
                ]
              : [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.notifications, size: 40))
                ],
        ),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          onPageChanged: (pageIndex) =>
              context.read<PageUpdateCubit>().setPageIndex(pageIndex),
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
            currentIndex: state.index,
            onTap: (value) {
              context.read<PageUpdateCubit>().setPageIndex(value);
              _pageController.jumpToPage(value);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Image.asset('assets/images/home.png',
                      height: 24, color: color(0)),
                  label: isClient() ? 'Home' : 'Appointments'),
              BottomNavigationBarItem(
                  icon: Image.asset('assets/images/doctor.png',
                      height: 24, color: color(1)),
                  label: isClient() ? 'Doctors' : 'My Patients'),
              BottomNavigationBarItem(
                  icon: Image.asset('assets/images/nurse.png',
                      height: 24, color: color(2)),
                  label: 'Aya'),
              BottomNavigationBarItem(
                  icon: Image.asset('assets/images/male-user.png',
                      height: 24, color: color(3)),
                  label: 'Profile')
            ]),
      );
    });
  }
}

// class PageNotifier extends ValueNotifier<int> {
//   PageNotifier({required int value}) : super(value);

//   set index(int value) {
//     this.value = value;
//     notifyListeners();
//   }
// }
