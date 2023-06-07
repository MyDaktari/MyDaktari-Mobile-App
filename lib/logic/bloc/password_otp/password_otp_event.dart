part of 'password_otp_bloc.dart';

abstract class PasswordOtpEvent extends Equatable {
  const PasswordOtpEvent();

  @override
  List<Object> get props => [];
}

class RequestPasswordOtp extends PasswordOtpEvent {
  final String email;
  final UserType userType;
  RequestPasswordOtp({required this.email, required this.userType});
  @override
  List<Object> get props => [email];
}

class VerifyPasswordOtp extends PasswordOtpEvent {
  final String email, PasswordOtp;
  VerifyPasswordOtp({required this.email, required this.PasswordOtp});
  @override
  List<Object> get props => [email, PasswordOtp];
}
