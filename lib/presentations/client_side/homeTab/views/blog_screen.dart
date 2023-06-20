import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/models/models.dart';

class BlogScreen extends StatelessWidget {
  const BlogScreen({super.key, required this.blog});
  final BlogModel blog;
  @override
  Widget build(BuildContext context) {
    final style = '''
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-9ndCyUaIbzAi2FUVXJi0CjmCapSmO7SnpJef0486qhLnuZ2cdeRhO02iuK6FUUVM" crossorigin="anonymous">
${blog.content}
    ''';
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
                  Html(
                    data: style,
                    style: {
                      'body': Style(
                        fontSize: FontSize(16.0),
                        margin: Margins.all(8.0),
                      ),
                      'p': Style(
                        fontSize: FontSize(16.0),
                        margin: Margins.only(bottom: 8.0),
                      ),
                      'h1': Style(
                        fontSize: FontSize(20.0),
                        fontWeight: FontWeight.bold,
                        margin: Margins.symmetric(vertical: 16.0),
                      ),
                    },
                  ),
                  // Text('Author ${blog.content}',
                  //     style: Theme.of(context).textTheme.bodyLarge),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
