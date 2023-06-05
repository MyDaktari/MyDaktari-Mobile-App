part of 'info_page_update_cubit.dart';

class InfoPageUpdateState extends Equatable {
  final int index;
  final int pagesNumber;
  const InfoPageUpdateState({required this.index, required this.pagesNumber});

  @override
  List<Object> get props => [index, pagesNumber];
}
