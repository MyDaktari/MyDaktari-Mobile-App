import 'package:flutter/material.dart';
import 'package:my_daktari/constants/route.dart' as route;

import '../../../../constants/colors.dart';

Future<dynamic> loginDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('My Daktari',
                    style: Theme.of(context).textTheme.displaySmall!.copyWith(
                        color: AppColor.primaryColor,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.cancel,
                        size: 35, color: AppColor.primaryColor))
              ],
            ),
            const Divider(thickness: 2),
          ]),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                  "To access personalized recommendations, connect with doctors, and make the most of our app's features, please log in or create an account",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: AppColor.primaryColor),
                        borderRadius: BorderRadius.circular(10)),
                    fixedSize: const Size(100, 40)),
                child: const Text('Cancel')),
            TextButton(
                onPressed: () =>
                    Navigator.pushNamed(context, route.loginScreen),
                style: TextButton.styleFrom(
                    backgroundColor: AppColor.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    fixedSize: const Size(100, 40)),
                child: const Text('Sign In',
                    style: TextStyle(color: Colors.white))),
          ],
        );
      });
}
