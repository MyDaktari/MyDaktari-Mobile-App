import 'package:flutter/material.dart';

class SupplierHomeButton extends StatelessWidget {
  const SupplierHomeButton(
      {super.key,
      required this.title,
      required this.color,
      required this.icon});
  final String title;
  // final Function onTap;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      margin: EdgeInsets.symmetric(vertical: 7),
      child: Container(
        height: 65,
        padding: EdgeInsets.only(left: 50, right: 5),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title,
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.w600)),
            Container(
              height: 55,
              width: 55,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(10)),
              child: Icon(icon, size: 30, color: Colors.white),
            )
          ],
        ),
      ),
    );
  }
}
