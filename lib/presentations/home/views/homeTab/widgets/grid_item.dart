import 'package:flutter/material.dart';

class HomeGridItem extends StatelessWidget {
  const HomeGridItem({
    super.key,
    required this.grid,
  });

  final Map<String, dynamic> grid;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, grid['route']),
      onHover: (val) {},
      child: Container(
        decoration:
            BoxDecoration(border: Border.all(color: Colors.grey, width: .5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset(
              grid['image'],
              height: 30,
            ),
            Text(grid['title'])
          ],
        ),
      ),
    );
  }
}
