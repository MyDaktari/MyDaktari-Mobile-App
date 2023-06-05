import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class UploadContainer extends StatelessWidget {
  final String document;
  final String description;
  const UploadContainer(
      {Key? key, required this.document, required this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return DottedBorder(
      color: Colors.blue,
      strokeWidth: 1.0,
      borderType: BorderType.RRect,
      radius: const Radius.circular(10.0),
      child: Container(
        // height: size.height * .21,
        width: size.width * 0.8,
        padding: const EdgeInsets.all(16.0),
        color: Colors.blue.withOpacity(.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(document,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12.0),
            Text(description,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.grey)),
            const SizedBox(height: 16.0),
            Container(
              decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(.09), shape: BoxShape.circle),
              child: const Icon(Icons.add, color: Colors.lightBlue, size: 40.0),
            ),
          ],
        ),
      ),
    );
  }
}
