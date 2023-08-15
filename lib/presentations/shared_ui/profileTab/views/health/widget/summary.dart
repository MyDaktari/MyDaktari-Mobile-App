import 'package:flutter/material.dart';

class HealthSummaryTile extends StatelessWidget {
  final String label;
  final String value;

  HealthSummaryTile({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: TextStyle(fontSize: 16.0)),
        Text(value,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold)),
      ],
    );
  }
}
