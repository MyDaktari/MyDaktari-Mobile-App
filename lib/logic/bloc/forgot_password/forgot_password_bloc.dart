// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../repositories/authentication/authentication_repository.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final AuthenticationRepository _authenticationRepository;
  ForgotPasswordBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(ForgotPasswordInitial()) {
    on<SendResetTokenEvent>(_sendResetToken);
    on<ResendTokenEvent>(_resendToken);
    on<ResetPasswordEvent>(_resetPassword);
  }
  void _resendToken(ResendTokenEvent event, Emitter emit) async {
    emit(ForgotPasswordInitial());
  }

  void _sendResetToken(SendResetTokenEvent event, Emitter emit) async {
    emit(ForgotPasswordLoading());
    try {
      if (event.email.isEmpty) {
        Fluttertoast.showToast(
          msg: 'Enter an email address',
        );
        return emit(ErrorState(message: 'Fill out the email'));
      }
      final data = await _authenticationRepository.sendResetToken(
        email: event.email,
      );

      Fluttertoast.showToast(msg: data);
      emit(TokenSentState());
    } catch (error) {
      final message = error.toString().contains("host lookup")
          ? 'Connect to the internet '
          : error.toString().split("Exception:").last;
      Fluttertoast.showToast(
        msg: 'Sending OTP failed $message',
      );
      emit(ErrorState(message: '$error'));
    }
  }

  void _resetPassword(ResetPasswordEvent event, Emitter emit) async {
    emit(ForgotPasswordLoading());
    try {
      final data = await _authenticationRepository.resetPassword(
        token: event.token,
        password: event.newPassword,
        confirmPassword: event.confirmPassword,
        email: event.email,
      );
      Fluttertoast.showToast(msg: data);
      emit(PasswordResetState());
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
