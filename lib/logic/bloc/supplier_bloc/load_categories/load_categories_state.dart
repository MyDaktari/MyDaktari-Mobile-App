part of 'load_categories_bloc.dart';

abstract class LoadCategoriesState extends Equatable {
  const LoadCategoriesState();

  @override
  List<Object> get props => [];
}

class CategoriesLoading extends LoadCategoriesState {}

class CategoriesLoaded extends LoadCategoriesState {
  final List<CategoryModel> categories;
  const CategoriesLoaded({required this.categories});
}

class CategoriesLoadError extends LoadCategoriesState {
  final String errorMessage;

  const CategoriesLoadError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
