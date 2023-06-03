import 'package:flutter/material.dart';

class LineWidget extends StatelessWidget {
  final bool active;
  const LineWidget({super.key, this.active = false});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 50,
          height: 3,
          color: active ? const Color(0xff0154ba) : Colors.grey,
        ),
        const SizedBox(
          width: 14,
        ),
      ],
    );
  }
}
