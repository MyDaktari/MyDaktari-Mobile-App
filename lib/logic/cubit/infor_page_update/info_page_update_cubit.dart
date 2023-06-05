import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'info_page_update_state.dart';

class InfoPageUpdateCubit extends Cubit<InfoPageUpdateState> {
  InfoPageUpdateCubit() : super(InfoPageUpdateState(index: 0, pagesNumber: 3));
  void setPageIndex(int index) {
    emit(InfoPageUpdateState(index: index, pagesNumber: 3));
  }

  int getPageIndex() {
    return state.index;
  }
}
