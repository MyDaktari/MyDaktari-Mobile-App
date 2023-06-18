import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../constants/enums.dart';

part 'welcome_message_state.dart';

class WelcomeMessageCubit extends Cubit<WelcomeMessageState> {
  WelcomeMessageCubit()
      : super(WelcomeMessageState(
            showMessage: false, userType: UserType.unchoise));

  void setMessage({required bool showMessafe, required UserType userType}) {
    emit(WelcomeMessageState(showMessage: showMessafe, userType: userType));
  }
}
