import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/constants/enums.dart';

import '../../../models/models.dart';
import '../../../repositories/authentication/authentication_repository.dart';

part 'auth_status_event.dart';
part 'auth_status_state.dart';

class AuthStatusBloc extends Bloc<AuthStatusEvent, AuthStatusState> {
  final AuthenticationRepository authRepository;
  AuthStatusBloc({required AuthenticationRepository authRepository})
      : authRepository = authRepository,
        super(AuthStatusLoding()) {
    on<CheckUserStatus>(_onCheckUserStatus);
    on<logUserOut>(_onlogUserOut);
  }
  void _onCheckUserStatus(
      CheckUserStatus event, Emitter<AuthStatusState> emit) async {
    emit(AuthStatusLoding());
    try {
      Map<String, dynamic> response = await authRepository.checkUser();
      if (response['user'] != null && response['userType'] != null) {
        if (response['userType'] == UserType.client) {
          userId = (response['user'] as ClientModel).userID.toString();
          userPhoneNumber = (response['user'] as ClientModel).phone.toString();
        } else {
          userId = (response['user'] as DoctorModel).id.toString();
          userPhoneNumber = (response['user'] as DoctorModel).phone.toString();
        }
        emit(UserAuthenticated(
            user: response['user'], userType: response['userType']));
      } else {
        userId = '';
        emit(UserUnauthenticated());
      }
    } catch (error) {
      userId = '';
      emit(UserUnauthenticated());
    }
  }

  void _onlogUserOut(logUserOut event, Emitter<AuthStatusState> emit) async {
    emit(AuthStatusLoding());
    try {
      bool response = await authRepository.logOut();
      if (response) emit(UserUnauthenticated());
    } catch (error) {
      emit(UserAuthStatusError(message: 'We could not log you out, Try again'));
    }
  }
}
