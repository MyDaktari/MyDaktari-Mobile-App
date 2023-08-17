import 'package:flutter/material.dart';
import 'package:my_daktari/constants/colors.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: AppColor.lightGrey, borderRadius: BorderRadius.circular(10)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(height: 10),
        Text(
          'ORDER NUMBER: 123456789',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColor.blackText),
        ),
        SizedBox(height: 10),
        Text(
          'YOU PAID: KSH 1000',
          style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColor.blackText),
        ),
        SizedBox(height: 10),
        Text(
          'Placed on: 14th Nov, 2023, 04:57pm',
          style: TextStyle(
              fontSize: 16,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w500,
              color: AppColor.blackText),
        ),
        SizedBox(height: 10),
        Container(
            height: 40,
            margin: EdgeInsets.symmetric(vertical: 5),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColor.lightGreen,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text('Delivered',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white))),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text('View Details',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColor.primaryColor)),
            SizedBox(width: 10),
            Icon(Icons.arrow_forward_ios_rounded,
                color: AppColor.primaryColor, size: 20)
          ],
        )
      ]),
    );
  }
}
