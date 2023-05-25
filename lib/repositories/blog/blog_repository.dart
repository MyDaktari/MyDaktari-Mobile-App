import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../constants/urls.dart';
import '../../models/models.dart';
import 'base_blog_repository.dart';

class BlogRepository extends BaseBlogRepository {
  //get doctor appointments.
  @override
  Future<List<BlogModel>> getBlogs() async {
    List<BlogModel> blogs = List.empty();
    final response = await http.post(Uri.parse(blogUrl),
        headers: {'Content-Type': 'application/json'});
    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body)['data'] as List;
      blogs = jsonData.map((blog) => BlogModel.fromJson(blog)).toList();
      return blogs;
    } else if (response.statusCode == 404) {
      return blogs = List.empty();
    } else {
      print(response.statusCode);
      throw Exception('Failed to login');
    }
  }
}
