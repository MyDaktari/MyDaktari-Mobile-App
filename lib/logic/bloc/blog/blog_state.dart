part of 'blog_bloc.dart';

abstract class BlogState extends Equatable {
  const BlogState();

  @override
  List<Object> get props => [];
}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {
  final List<BlogModel> blogs;

  const BlogLoaded({this.blogs = const <BlogModel>[]});
  @override
  List<Object> get props => [blogs];
}

class BlogLoadingError extends BlogState {
  final String message;

  const BlogLoadingError({required this.message});
  @override
  List<Object> get props => [message];
}
