part of 'reset_password_bloc.dart';

abstract class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class ResetPassword extends ResetPasswordEvent {
  final UserType userType;
  final String newPassword;
  final String userId;
  const ResetPassword(
      {required this.userId,
      required this.userType,
      required this.newPassword});
  @override
  List<Object> get props => [userType, newPassword, userId];
}
