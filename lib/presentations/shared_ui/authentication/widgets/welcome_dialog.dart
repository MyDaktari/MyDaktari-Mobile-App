import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

Future<dynamic> welcomeDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Mydaktari',
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: AppColor.primaryColor, fontSize: 25)),
                IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.cancel,
                        size: 35, color: AppColor.primaryColor))
              ],
            ),
            const Divider(thickness: 2),
            Text('Welcome Back !',
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall!
                    .copyWith(fontSize: 20, fontWeight: FontWeight.bold)),
          ]),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(context),
                style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        side: BorderSide(color: AppColor.primaryColor),
                        borderRadius: BorderRadius.circular(10)),
                    fixedSize: const Size(100, 40)),
                child: const Text('Continue',
                    style: TextStyle(color: Colors.black))),
          ],
        );
      });
}
