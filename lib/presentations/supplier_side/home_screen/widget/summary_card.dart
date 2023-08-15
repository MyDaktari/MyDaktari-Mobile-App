import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

class SummaryCard extends StatelessWidget {
  const SummaryCard(
      {super.key,
      required this.color,
      required this.tite,
      this.width = double.infinity,
      required this.value});

  final Color color;
  final String tite;
  final String value;
  final double width;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: color.withOpacity(0.1),
      ),
      margin: EdgeInsets.only(top: 10),
      height: size.height * 0.17,
      width: width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(value,
                style: TextStyle(
                    fontSize: 30, fontWeight: FontWeight.bold, color: color)),
            SizedBox(height: 5),
            Text(tite,
                maxLines: 2,
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w500,
                    color: AppColor.blackText)),
          ],
        ),
      ),
    );
  }
}
