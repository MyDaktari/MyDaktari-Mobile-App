import 'package:flutter/material.dart';
import 'package:my_daktari/constants/constants.dart';

class PatientAppointment extends StatelessWidget {
  PatientAppointment({super.key});
  final TabNotifier _tabNotifier = TabNotifier(0);
  final PageController _pageController = PageController();
  List<Widget> tabs(int tabValue) {
    List<String> titles = ['Today', 'Upcoming', 'Pending', 'History'];
    return titles.map((title) {
      int index = titles.indexOf(title);
      return tab(title, index, tabValue);
    }).toList();
  }

  Widget tab(String title, int index, int tabValue) {
    return GestureDetector(
      onTap: () {
        _tabNotifier.newValue = index;
        _pageController.animateToPage(index,
            duration: Duration(milliseconds: 200), curve: Curves.linear);
      },
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: tabValue == index ? primaryColor : Colors.grey,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            height: 10,
            decoration: BoxDecoration(
                color: tabValue == index ? primaryColor : Colors.grey,
                borderRadius: BorderRadius.horizontal(
                    left: Radius.circular(index == 0 ? 20 : 0),
                    right: Radius.circular(index == 3 ? 20 : 0))),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return ValueListenableBuilder(
        valueListenable: _tabNotifier,
        builder: (context, tabValue, _) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Appointments',
                  style: textTheme.titleLarge,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    'You have the following appointments',
                    style: textTheme.bodyMedium?.copyWith(fontSize: 21),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: tabs(tabValue)
                          .map((tab) => Expanded(
                                child: tab,
                              ))
                          .toList(),
                    ),
                  ),
                ),
                Expanded(
                    child: PageView(
                  controller: _pageController,
                  onPageChanged: (val) {
                    _tabNotifier.newValue = val;
                  },
                  children: [
                    AppointmentList(
                      list: List.generate(2, (index) => null).toList(),
                    ),
                    AppointmentList(
                        list: List.generate(3, (index) => null).toList()),
                    AppointmentList(
                        list: List.generate(1, (index) => null).toList()),
                    AppointmentList(
                        list: List.generate(4, (index) => null).toList()),
                  ],
                ))
              ],
            ),
          );
        });
  }
}

class AppointmentList extends StatelessWidget {
  const AppointmentList({
    super.key,
    required this.list,
  });
  final List list;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              color: primaryColor,
              child: SizedBox(
                height: 150,
                width: double.infinity,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white),
                      child: Image.asset('assets/images/male-user.png'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            '12:00 PM',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'John Doe',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 21,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'Allergies',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.more_horiz,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class TabNotifier extends ValueNotifier<int> {
  TabNotifier(int value) : super(value);

  set newValue(int value) {
    this.value = value;
    notifyListeners();
  }
}
