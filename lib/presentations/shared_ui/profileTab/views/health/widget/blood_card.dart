import 'package:flutter/material.dart';
import '../../../../../../constants/route.dart' as route;
import '../../../../../../constants/colors.dart';

class BloodHomeCard extends StatelessWidget {
  const BloodHomeCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route.bloodGlucoseScreen);
      },
      child: Card(
        child: Container(
          height: 100,
          alignment: Alignment.center,
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Icon(Icons.water_drop_rounded, color: Colors.red),
                  Text('Blood glucose',
                      style: TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold))
                ],
              ),
              Row(
                children: [
                  Text('0.2',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColor.primaryColor)),
                  Text(' mmo;/L', style: TextStyle(fontSize: 15)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
