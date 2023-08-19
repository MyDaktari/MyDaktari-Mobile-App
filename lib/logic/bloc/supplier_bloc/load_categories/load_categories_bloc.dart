import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/category.dart';
import '../../../../repositories/supplier/product/product_repository.dart';
part 'load_categories_event.dart';
part 'load_categories_state.dart';

class LoadCategoriesBloc extends Bloc<CategoriesEvent, LoadCategoriesState> {
  final ProductRepository _CategoriesRepository;

  LoadCategoriesBloc({required ProductRepository CategoriesRepository})
      : _CategoriesRepository = CategoriesRepository,
        super(CategoriesLoading()) {
    on<LoadCategories>(_onLoadByBrand);
  }

  void _onLoadByBrand(
      LoadCategories event, Emitter<LoadCategoriesState> emit) async {
    try {
      emit(CategoriesLoading());
      List<CategoryModel> Categories =
          await _CategoriesRepository.getProductCategories();
      emit(CategoriesLoaded(categories: Categories));
    } catch (error) {
      final message = error.toString().contains("host lookup")
          ? 'Connect to the internet '
          : error.toString().split("Exception:").last;
      emit(CategoriesLoadError(errorMessage: message));
    }
  }
}
