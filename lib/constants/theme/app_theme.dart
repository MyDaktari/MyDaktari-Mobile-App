import 'package:flutter/material.dart';
import '../colors.dart';

class AppTheme {
  get lightTheme => ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21)),
                backgroundColor: AppColor.primaryColor)),
        textTheme: TextTheme(
            titleLarge: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColor.primaryColor)),
        fontFamily: AppColor.fontFamily,
        primaryColor: AppColor.primaryColor,
        brightness: Brightness.light,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          selectedItemColor: AppColor.primaryColor,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
        ),
        appBarTheme: AppBarTheme(
            backgroundColor: ThemeData.light().scaffoldBackgroundColor,
            titleTextStyle: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
                fontSize: 23,
                fontFamily: AppColor.fontFamily),
            iconTheme: IconThemeData(color: AppColor.primaryColor),
            elevation: 0),
      );
}
