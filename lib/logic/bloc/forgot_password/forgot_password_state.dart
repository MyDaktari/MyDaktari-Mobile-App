part of 'forgot_password_bloc.dart';

abstract class ForgotPasswordState extends Equatable {
  const ForgotPasswordState();

  @override
  List<Object> get props => [];
}

class ForgotPasswordInitial extends ForgotPasswordState {}

class ForgotPasswordLoading extends ForgotPasswordState {}

class TokenSentState extends ForgotPasswordState {}

class PasswordResetState extends ForgotPasswordState {}

class ErrorState extends ForgotPasswordState {
  final String message;

  const ErrorState({required this.message});
}
