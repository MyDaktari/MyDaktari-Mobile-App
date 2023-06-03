import 'package:flutter/material.dart';

import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/models/models.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key, required this.blog});
  final BlogModel blog;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${blog.title}',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_sharp, color: Colors.white)),
        elevation: 0,
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(blog.featuredImage!),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${blog.title}',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Author ${blog.author}'),
                      Row(
                        children: [
                          Icon(Icons.access_time_outlined),
                          SizedBox(width: 10),
                          Text(formatRelativeTime(
                              DateTime.parse(blog.date.toString()))),
                        ],
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Text('Author ${blog.content}',
                      style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
