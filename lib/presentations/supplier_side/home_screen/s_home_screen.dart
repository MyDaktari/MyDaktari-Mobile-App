import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import 'pages/supplier_home_page.dart';
import 'pages/supplier_profile_page.dart';
import 'pages/supplier_settings_page.dart';

class SupplierHomeScreen extends StatefulWidget {
  SupplierHomeScreen({super.key});

  @override
  State<SupplierHomeScreen> createState() => _SupplierHomeScreenState();
}

class _SupplierHomeScreenState extends State<SupplierHomeScreen> {
  final pages = <Widget>[
    SupplierSettingPage(),
    SupplierHomePage(),
    SupplierProfilePage(),
  ];
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColor.bankground,
        body: SafeArea(child: pages.elementAt(currentIndex)),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: (value) => setState(() {
            currentIndex = value;
          }),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.settings_outlined),
              label: 'settings',
              backgroundColor: AppColor.primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined),
              label: 'Home',
              backgroundColor: AppColor.primaryColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
              backgroundColor: AppColor.primaryColor,
            ),
          ],
        ));
  }
}
