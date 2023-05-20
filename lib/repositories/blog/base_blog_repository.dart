import '../../models/models.dart';

abstract class BaseBlogRepository {
  Future<List<BlogModel>?> getBlogs() async {}
}
