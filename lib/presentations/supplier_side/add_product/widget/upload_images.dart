import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

class UploadProductImages extends StatelessWidget {
  const UploadProductImages({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: AppColor.lightGrey, borderRadius: BorderRadius.circular(10)),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              'Product Image (upload Multiple)',
              style: TextStyle(
                  color: AppColor.blackText,
                  fontWeight: FontWeight.w600,
                  fontSize: 16),
            ),
            Icon(Icons.photo_library_outlined, color: AppColor.blackText),
          ],
        ),
      ),
    );
  }
}
