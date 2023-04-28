import 'package:flutter/material.dart';

class DisclaimerDialog extends StatelessWidget {
  const DisclaimerDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      actionsAlignment: MainAxisAlignment.center,
      actionsPadding: const EdgeInsets.all(15),
      contentPadding: const EdgeInsets.all(15),
      titlePadding: EdgeInsets.zero,
      title: Container(
        height: 50,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            color: Color.fromARGB(255, 1, 84, 186)),
        child: const Center(
          child: Text(
            'Disclaimer',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white),
          ),
        ),
      ),
      content: const Text(
        """This app provides useful information but is not a substitute for professional medical advice, diagnosis or treatment. If you think you may have a medical emergency, immediately call your doctor or dial 999.\nBefore acting on any of the information in MyDaktari, consult with your doctor to make sure that it is right for you.""",
        textAlign: TextAlign.justify,
        style: TextStyle(fontWeight: FontWeight.normal, fontSize: 15),
      ),
      actions: [
        ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 1, 84, 186)),
            onPressed: () => Navigator.pop(context),
            child: const SizedBox(
                width: double.infinity,
                child: Center(child: Text('I understand'))))
      ],
    );
  }
}
