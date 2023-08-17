// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_daktari/constants/enums.dart';

import '../../../../repositories/shared_repositories/authentication/authentication_repository.dart';

part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final AuthenticationRepository _authenticationRepository;
  ResetPasswordBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(ResetPasswordInitial()) {
    on<ResetPassword>(_resetPassword);
  }

  void _resetPassword(ResetPassword event, Emitter emit) async {
    emit(ResetPasswordLoading());
    try {
      final data = await _authenticationRepository.resetPassword(
          userId: event.userId,
          userType: event.userType,
          password: event.newPassword);
      Fluttertoast.showToast(msg: data);
      emit(ResetPasswordLoaded());
    } catch (error) {
      final message = error.toString().contains("host lookup")
          ? 'Connect to the internet '
          : error.toString().split("Exception:").last;
      Fluttertoast.showToast(
        msg: 'Resetting password failed $message',
      );
      emit(ErrorState(message: '$error'));
    }
  }
}
