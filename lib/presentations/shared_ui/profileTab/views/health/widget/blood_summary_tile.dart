import 'package:flutter/material.dart';

class BloodSummaryTile extends StatelessWidget {
  final String label;
  final String value;
  const BloodSummaryTile({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: .5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: SizedBox(
        height: 60,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label,
                  style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
              //value with 2 decimal places
              Text('${double.parse(value).toStringAsFixed(1)} mg/dL',
                  style: TextStyle(fontSize: 18.0)),
            ],
          ),
        ),
      ),
    );
  }
}
