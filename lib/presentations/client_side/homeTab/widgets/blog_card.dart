import 'package:flutter/material.dart';

import 'package:my_daktari/constants/route.dart' as route;

import '../../../../constants/colors.dart';
import '../../../../constants/constants.dart';
import '../../../../models/blog.dart';

class BlogCard extends StatelessWidget {
  const BlogCard({super.key, required this.blog});

  final BlogModel blog;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () =>
            Navigator.pushNamed(context, route.blogScreen, arguments: blog),
        child: Card(
          elevation: 1,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: SizedBox(
            height: 250,
            width: size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                    clipBehavior: Clip.antiAlias,
                    height: 150,
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10)),
                        color: AppColor.primaryColor),
                    child:
                        Image.network(blog.featuredImage!, fit: BoxFit.cover)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(blog.title ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .displaySmall!
                              .copyWith(
                                  fontSize: 16,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis),
                      // Container(
                      //   height: 30,
                      //   color: Colors.amber,
                      //   width: double.infinity,
                      //   child: Html(data: blog.content),
                      // ),
                      // Text(blog.content ?? '',
                      //     style: Theme.of(context).textTheme.bodyLarge,
                      //     maxLines: 2,
                      //     overflow: TextOverflow.ellipsis),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(blog.author ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(fontSize: 16)),
                          Text(
                              formatRelativeTime(
                                  DateTime.parse(blog.date.toString())),
                              style: Theme.of(context)
                                  .textTheme
                                  .displaySmall!
                                  .copyWith(fontSize: 16)),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
