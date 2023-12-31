import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

Future<dynamic> diviceDialog(BuildContext context) {
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
              CupertinoActivityIndicator(
                animating: true,
                radius: 20,
              ),
              SizedBox(height: 15),
              Text("Connecting your device, just a moment...",
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(fontWeight: FontWeight.bold, fontSize: 18)),
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
          ],
        );
      });
}
