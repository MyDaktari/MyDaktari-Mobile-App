import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/constants/enum_user_type.dart';

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
        userId = (response['userType'] == UserType.client)
            ? (response['user'] as ClientModel).userID.toString()
            : (response['user'] as DoctorModel).id.toString();

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
