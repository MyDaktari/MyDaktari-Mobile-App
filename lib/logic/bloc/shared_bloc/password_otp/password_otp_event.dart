part of 'password_otp_bloc.dart';

abstract class PasswordOtpEvent extends Equatable {
  const PasswordOtpEvent();

  @override
  List<Object> get props => [];
}

class RequestPasswordOtp extends PasswordOtpEvent {
  final String phoneNumber;
  final UserType userType;
  RequestPasswordOtp({required this.phoneNumber, required this.userType});
  @override
  List<Object> get props => [phoneNumber];
}

class VerifyPasswordOtp extends PasswordOtpEvent {
  final String phoneNumber, PasswordOtp;
  VerifyPasswordOtp({required this.phoneNumber, required this.PasswordOtp});
  @override
  List<Object> get props => [phoneNumber, PasswordOtp];
}
