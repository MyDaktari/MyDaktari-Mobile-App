part of 'load_categories_bloc.dart';

abstract class CategoriesEvent extends Equatable {
  const CategoriesEvent();

  @override
  List<Object> get props => [];
}

class LoadCategories extends CategoriesEvent {
  const LoadCategories();
  @override
  List<Object> get props => [];
}
