import 'package:flutter/material.dart';
import 'package:my_daktari/screens/auth/services/auth_page_provider.dart';
import 'package:my_daktari/screens/home/views/ayaTab/views/aya_tab.dart';
import 'package:my_daktari/screens/home/views/doctorsTab/views/doctors_tab.dart';
import 'package:my_daktari/screens/home/views/homeTab/views/home_tab.dart';
import 'package:my_daktari/screens/home/views/profileTab/views/profile_tab.dart';
import 'package:my_daktari/screens/home/widgets/disclaimer.dart';
import 'package:my_daktari/constants/constants.dart' as constants;
import 'package:my_daktari/routes/app_route.dart' as routes;
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final PageNotifier _pageNotifier = PageNotifier(value: 0);
  final PageController _pageController = PageController(initialPage: 0);
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
          label: 'Home'),
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/images/doctor.png',
            height: 24,
            color: color(1),
          ),
          label: 'Doctors'),
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

  final DisclalimerNotifier _disclalimerNotifier =
      DisclalimerNotifier(value: false);
  @override
  Widget build(BuildContext context) {
    AuthPageProvider authPageProvider = context.read<AuthPageProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _disclalimerNotifier.value
          ? debugPrint('disclaimer already shown')
          : showDialog(
                  context: context,
                  builder: (context) => const DisclaimerDialog())
              .then((value) => _disclalimerNotifier.disclaimerShown = true);
    });
    return ValueListenableBuilder(
        valueListenable: _pageNotifier,
        builder: (context, currentIndex, _) {
          return Scaffold(
            appBar: AppBar(
              toolbarHeight: currentIndex == 1
                  ? 0
                  : Theme.of(context).appBarTheme.toolbarHeight,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.menu_rounded,
                    size: 50,
                    //  color: Color.fromARGB(255, 1, 84, 186),
                  )),
              title: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Builder(builder: (context) {
                  switch (currentIndex) {
                    case 0:
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(12),
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
                              authPageProvider.setRegister(false);
                              Navigator.pushReplacementNamed(
                                  context, routes.authPage);
                            },
                            child: const Text(
                              'Sign In',
                              style: TextStyle(fontSize: 18),
                            )),
                      )
                    ]
                  : [],
            ),
            body: PageView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _pageController,
              onPageChanged: (page) => _pageNotifier.index = page,
              children: [
                HomeTabView(),
                DoctorsTab(),
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

class DisclalimerNotifier extends ValueNotifier<bool> {
  DisclalimerNotifier({required bool value}) : super(value);
  set disclaimerShown(bool value) {
    this.value = value;
    notifyListeners();
  }
}
