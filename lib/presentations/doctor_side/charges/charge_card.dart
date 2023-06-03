import 'package:flutter/material.dart';
import 'package:my_daktari/presentations/doctor_side/charges/dropdown.dart';

import '../personnal_info/widgets/text_field.dart';

class ChargeWidget extends StatelessWidget {
  const ChargeWidget({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title),
        SizedBox(height: 10),
        Row(
          children: [
            Container(
                width: 200, child: TextWidget(label: 'Ksh ', isNumber: true)),
            ChargeDropDown(title: title)
          ],
        )
      ],
    );
  }
}
