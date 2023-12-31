import 'package:flutter/material.dart';

import '../../constants/colors.dart';

Future<void> welcomeDialog(
    {required BuildContext context,
    required String message,
    required String title}) async {
  WidgetsBinding.instance.addPersistentFrameCallback(
    (_) {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Column(
              children: [
                Text(title,
                    textAlign: TextAlign.center,
                    style: Theme.of(context)
                        .textTheme
                        .headlineLarge!
                        .copyWith(fontSize: 22, fontWeight: FontWeight.bold)),
                const Divider(thickness: 1)
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 16),
                  Text(message,
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge!
                          .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
            actionsAlignment: MainAxisAlignment.center,
            actionsPadding:
                const EdgeInsets.only(right: 20, left: 20, bottom: 10),
            actions: [
              ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: AppColor.primaryColor),
                  child: const Text('Continue')),
            ],
          );
        },
      );
    },
  );
}
