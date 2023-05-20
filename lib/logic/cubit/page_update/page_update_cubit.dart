import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_update_state.dart';

class PageUpdateCubit extends Cubit<PageUpdateState> {
  PageUpdateCubit() : super(PageUpdateState(index: 0));
  void setPageIndex(int index) {
    emit(PageUpdateState(index: index));
  }

  int getPageIndex() {
    return state.index;
  }
}
