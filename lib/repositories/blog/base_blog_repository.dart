// ignore_for_file: body_might_complete_normally_nullable

import '../../models/models.dart';

abstract class BaseBlogRepository {
  Future<List<BlogModel>?> getBlogs() async {}
}
