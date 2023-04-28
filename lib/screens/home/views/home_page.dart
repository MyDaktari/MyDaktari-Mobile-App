import 'package:flutter/material.dart';
import 'package:my_daktari/screens/home/views/homeTab/views/home_tab.dart';
import 'package:my_daktari/screens/home/widgets/disclaimer.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final PageNotifier _pageNotifier = PageNotifier(value: 0);
  Color color(int index) {
    return _pageNotifier.value == index
        ? const Color.fromARGB(255, 1, 84, 186)
        : Colors.grey;
  }

  List<BottomNavigationBarItem> bottomNavigationBarItems() {
    return [
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/home.png',
            height: 24,
            color: color(0),
          ),
          label: 'Home'),
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/doctor.png',
            height: 24,
            color: color(1),
          ),
          label: 'Doctors'),
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/nurse.png',
            height: 24,
            color: color(2),
          ),
          label: 'Aya'),
      BottomNavigationBarItem(
          icon: Image.asset(
            'assets/male-user.png',
            height: 24,
            color: color(3),
          ),
          label: 'Profile')
    ];
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(context: context, builder: (context) => DisclaimerDialog());
    });
    Size size = MediaQuery.of(context).size;
    return ValueListenableBuilder(
        valueListenable: _pageNotifier,
        builder: (context, currentIndex, _) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              elevation: 0,
              leading: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.menu_rounded,
                    size: 50,
                    color: Color.fromARGB(255, 1, 84, 186),
                  )),
              title: Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: ClipRRect(
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
                ),
              ),
            ),
            body: PageView(
              children: [HomeTabView()],
            ),
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: currentIndex,
                onTap: (value) => _pageNotifier.index = value,
                selectedItemColor: const Color.fromARGB(255, 1, 84, 186),
                showUnselectedLabels: true,
                unselectedItemColor: Colors.grey,
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
