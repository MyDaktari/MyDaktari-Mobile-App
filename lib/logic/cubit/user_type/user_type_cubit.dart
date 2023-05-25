import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../constants/enums.dart';

part 'user_type_state.dart';

class UserTypeCubit extends Cubit<UserTypeState> {
  UserTypeCubit() : super(UserTypeState(userType: UserType.unchoise));

  void switchToUser({required UserType userType}) {
    print(userType.toString());
    emit(UserTypeState(userType: userType));
  }

  UserType getUserType() {
    return state.userType;
  }
}
