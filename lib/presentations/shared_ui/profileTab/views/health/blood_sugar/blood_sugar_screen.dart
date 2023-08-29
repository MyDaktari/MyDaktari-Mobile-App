import 'package:flutter/material.dart';
import 'package:my_daktari/constants/colors.dart';
import '../../../../../../constants/route.dart' as route;
import 'graph/blood_graph.dart';

class BoodSugarScreen extends StatelessWidget {
  BoodSugarScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Blood Sugar Tracker')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('No readings yet',
                style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor)),
            SizedBox(height: 10.0),
            Text('Tap the + button to add a reading',
                style: TextStyle(fontSize: 15)),
            BloodGraph(),
          ],
        ),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamed(context, route.recordSugarScreen),
        backgroundColor: AppColor.lightGreen,
        child: const Icon(Icons.add, size: 28),
      ),
    );
  }
}
