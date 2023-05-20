import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_daktari/models/models.dart';
import 'package:my_daktari/repositories/blog/blog_repository.dart';

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
      emit(BlogLoaded(blogs: blogs));
    } catch (error) {
      emit(BlogLoadingError(message: error.toString()));
    }
  }
}
