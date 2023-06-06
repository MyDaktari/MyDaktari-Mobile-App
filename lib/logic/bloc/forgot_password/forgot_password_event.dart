part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class SendResetTokenEvent extends ForgotPasswordEvent {
  final String email;

  const SendResetTokenEvent({required this.email});
}

class ResetPasswordEvent extends ForgotPasswordEvent {
  final String confirmPassword;
  final String token;
  final String newPassword;
  final String email;

  const ResetPasswordEvent({
    required this.email,
    required this.confirmPassword,
    required this.token,
    required this.newPassword,
  });
}

class ResendTokenEvent extends ForgotPasswordEvent {
  final String email;

  const ResendTokenEvent({required this.email});

  @override
  List<Object> get props => [email];
}
