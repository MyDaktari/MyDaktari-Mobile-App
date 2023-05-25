part of 'page_update_cubit.dart';

class PageUpdateState extends Equatable {
  final int index;
  final PageController pageController;
  const PageUpdateState({required this.index, required this.pageController});

  @override
  List<Object> get props => [index];
}
