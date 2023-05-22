import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../repositories/authentication/authentication_repository.dart';

part 'auth_status_event.dart';
part 'auth_status_state.dart';

class AuthStatusBloc extends Bloc<AuthStatusEvent, AuthStatusState> {
  final AuthenticationRepository authRepository;
  AuthStatusBloc({required AuthenticationRepository authRepository})
      : authRepository = authRepository,
        super(AuthStatusLoding()) {
    on<CheckUserStatus>(_onCheckUserStatus);
  }
  void _onCheckUserStatus(
      CheckUserStatus event, Emitter<AuthStatusState> emit) async {
    emit(AuthStatusLoding());
    try {
      final user = await authRepository.checkUser();
      if (user != null) {
        print('hello88');
        emit(UserAuthenticated(user: user));
      } else {
        emit(UserUnauthenticated());
      }
    } catch (error) {
      emit(UserUnauthenticated());
    }
  }
}
