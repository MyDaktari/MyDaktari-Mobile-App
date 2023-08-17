part of 'password_otp_bloc.dart';

abstract class PasswordOtpState extends Equatable {
  const PasswordOtpState();

  @override
  List<Object> get props => [];
}

class PasswordOtpInitalize extends PasswordOtpState {}

class PasswordOtpLoading extends PasswordOtpState {}

class PasswordOtpLoaded extends PasswordOtpState {
  final String userId;
  PasswordOtpLoaded({required this.userId});
  @override
  List<Object> get props => [userId];
}

class PasswordOtpSet extends PasswordOtpState {}

class PasswordOtpLoadError extends PasswordOtpState {
  final String errorMessage;
  PasswordOtpLoadError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
