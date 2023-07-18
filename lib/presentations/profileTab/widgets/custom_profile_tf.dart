import 'package:flutter/material.dart';

class CustomProfileTextField extends StatelessWidget {
  const CustomProfileTextField(
      {super.key, required this.hintText, required this.controller});
  final String hintText;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.only(right: 10, left: 10),
      // margin: const EdgeInsets.only(top: 10),
      height: 100,
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(hintText,
              style: textTheme.displaySmall!
                  .copyWith(fontSize: 14, fontWeight: FontWeight.w700)),
          SizedBox(height: 10),
          TextField(
              controller: controller,
              decoration: const InputDecoration(
                fillColor: Color(0xfff0f3fc),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                contentPadding: EdgeInsets.symmetric(horizontal: 10),
              ),
              style: const TextStyle(
                  fontSize: 17.0,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
