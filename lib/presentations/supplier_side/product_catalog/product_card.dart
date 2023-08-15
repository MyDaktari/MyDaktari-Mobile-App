import 'package:flutter/material.dart';
import 'package:my_daktari/constants/colors.dart';

class SupplierProductCard extends StatelessWidget {
  const SupplierProductCard({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
          height: 120,
          width: size.width * .5,
          child: Row(
            children: <Widget>[
              Container(width: size.width * .2, height: 100, color: Colors.red),
              SizedBox(width: 10),
              Expanded(
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 8.0, bottom: 8.0, right: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Product Name',
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      Text('View Details',
                          style: TextStyle(color: AppColor.primaryColor))
                    ],
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
