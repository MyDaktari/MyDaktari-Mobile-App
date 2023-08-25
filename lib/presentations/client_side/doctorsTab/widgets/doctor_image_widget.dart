import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../constants/colors.dart';

class DoctorImageWidget extends StatelessWidget {
  const DoctorImageWidget({super.key, required this.imageUrl, this.size = 150});
  final String imageUrl;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: Container(
        padding: const EdgeInsets.all(3),
        color: AppColor.green,
        child: ClipOval(
          child: CachedNetworkImage(
              height: size,
              width: size,
              placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(strokeWidth: 1)),
              errorWidget: (context, url, error) =>
                  const Icon(Icons.error_outline, size: 54, color: Colors.red),
              imageUrl: imageUrl,
              fit: BoxFit.cover),
        ),
      ),
    );
  }
}
