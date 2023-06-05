import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../page_update/page_update_cubit.dart';

class PageUpdateCubit extends Cubit<PageUpdateState> {
  PageUpdateCubit()
      : super(PageUpdateState(
            index: 0, pageController: PageController(initialPage: 0)));
  void setPageIndex(int index) {
    state.pageController.jumpToPage(index);
    emit(PageUpdateState(
        index: index, pageController: PageController(initialPage: index)));
  }

  int getPageIndex() {
    return state.index;
  }

  @override
  Future<void> close() {
    state.pageController.dispose();
    return super.close();
  }
}
