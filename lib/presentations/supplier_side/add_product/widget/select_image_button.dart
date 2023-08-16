import 'package:flutter/material.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({
    super.key,
    required this.onPressed,
    required this.title,
    this.isCamera = false,
  });
  final String title;
  final VoidCallback onPressed;
  final bool isCamera;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 40,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.white),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(isCamera
                ? Icons.camera_alt_outlined
                : Icons.photo_library_outlined),
            const SizedBox(width: 10),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600))
          ],
        ),
      ),
    );
  }
}
