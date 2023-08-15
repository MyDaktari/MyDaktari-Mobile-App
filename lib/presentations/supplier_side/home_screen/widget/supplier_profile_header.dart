import 'package:flutter/material.dart';
import 'package:my_daktari/constants/colors.dart';

class SupplierProfileHeader extends StatelessWidget {
  const SupplierProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome Back,', style: TextStyle(fontSize: 17)),
            SizedBox(height: 10),
            Text('Supplier Name',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
          ],
        ),
        CircleAvatar(
            radius: 40,
            backgroundColor: AppColor.green,
            child: CircleAvatar(radius: 37, backgroundColor: Colors.white))
      ],
    );
  }
}
