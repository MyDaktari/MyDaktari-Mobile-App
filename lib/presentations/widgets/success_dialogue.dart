import 'package:flutter/material.dart';
import 'package:my_daktari/constants/constants.dart';

Future<dynamic> successDialog(
    {required BuildContext context,
    bool success = false,
    String route = '',
    required String message,
    required String title}) {
  return showDialog(
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
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(success ? Icons.check : Icons.cancel,
                  size: 48, color: success ? primaryColor : Colors.red),
              const SizedBox(height: 16),
              Text(success ? "Success" : "Error",
                  style: const TextStyle(
                      fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              Text(message,
                  style: Theme.of(context)
                      .textTheme
                      .headlineLarge!
                      .copyWith(fontSize: 16, fontWeight: FontWeight.w500),
                  textAlign: TextAlign.center),
            ],
          ),
          actionsAlignment: MainAxisAlignment.center,
          actionsPadding:
              const EdgeInsets.only(right: 20, left: 20, bottom: 10),
          actions: [
            ElevatedButton(
              onPressed: route.isEmpty
                  ? () => Navigator.pop(context)
                  : () {
                      Navigator.pushNamedAndRemoveUntil(
                          context, route, (Route route) => route.isFirst);
                      Navigator.pop(context);
                    },
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
              ),
              child: const Text('OK'),
            ),
          ],
        );
      });
}
