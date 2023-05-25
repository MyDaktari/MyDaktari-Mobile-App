import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tab_update_state.dart';

class TabUpdateCubit extends Cubit<TabUpdateState> {
  TabUpdateCubit() : super(TabUpdateState(tabValue: 0));
  void setTabValue(int value) {
    emit(TabUpdateState(tabValue: value));
  }
}
