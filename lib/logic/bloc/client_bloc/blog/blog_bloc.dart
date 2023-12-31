import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_daktari/models/models.dart';
import 'package:my_daktari/repositories/shared_repositories/blog/blog_repository.dart';

part 'blog_event.dart';
part 'blog_state.dart';

class BlogBloc extends Bloc<BlogEvent, BlogState> {
  BlogRepository _blogRepository;
  BlogBloc({required BlogRepository blogRepository})
      : _blogRepository = blogRepository,
        super(BlogLoading()) {
    on<LoadBlogs>(_onLoadBlogs);
  }
  void _onLoadBlogs(LoadBlogs event, Emitter<BlogState> emit) async {
    emit(BlogLoading());
    try {
      List<BlogModel> blogs = await _blogRepository.getBlogs();
      List<BlogModel> sortedBlogs = List.from(blogs);
      sortedBlogs
          .sort((a, b) => b.date!.compareTo(a.date!)); // Reverse the comparison
      emit(BlogLoaded(blogs: sortedBlogs));
    } catch (error) {
      final message = error.toString().contains("host lookup")
          ? 'Connect to the internet '
          : error.toString().split("Exception:").last;
      emit(BlogLoadingError(message: message));
    }
  }
}
