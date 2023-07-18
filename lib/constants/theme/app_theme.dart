import 'package:flutter/material.dart';
import 'package:my_daktari/constants/constants.dart' as constants;

class AppTheme {
  get lightTheme => ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                elevation: 0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(21)),
                backgroundColor: constants.primaryColor)),
        textTheme: const TextTheme(
            titleLarge: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: constants.primaryColor)),
        fontFamily: constants.fontFamily,
        primaryColor: constants.primaryColor,
        brightness: Brightness.light,
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          selectedItemColor: constants.primaryColor,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.grey,
        ),
        appBarTheme: AppBarTheme(
            backgroundColor: ThemeData.light().scaffoldBackgroundColor,
            titleTextStyle: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.bold,
                fontSize: 23,
                fontFamily: constants.fontFamily),
            iconTheme: const IconThemeData(color: constants.primaryColor),
            elevation: 0),
      );
}
