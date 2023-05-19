import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/authentication/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _repository;
  AuthenticationBloc({required AuthenticationRepository repository})
      : _repository = repository,
        super(AuthenticationInitial()) {
    on<RegisterClient>(_onRegisterClient);
    on<LoginClient>(_onLoginClient);
  }

  void _onRegisterClient(
      RegisterClient event, Emitter<AuthenticationState> emit) {
    emit(AuthenticationLoading());
    try {} catch (error) {
      emit(AuthenticationError(errorMessage: '$error'));
    }
  }

  void _onLoginClient(
      LoginClient event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      final client = await _repository.loginClient(
          username: event.username, password: event.password);
    } catch (error) {
      emit(AuthenticationError(errorMessage: '$error'));
    }
  }
}
