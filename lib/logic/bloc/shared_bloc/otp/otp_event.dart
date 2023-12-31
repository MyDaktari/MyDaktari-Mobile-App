part of 'otp_bloc.dart';

abstract class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [];
}

class RequestOtp extends OtpEvent {
  final String phoneNumber;
  RequestOtp({required this.phoneNumber});
  @override
  List<Object> get props => [phoneNumber];
}

class VerifyOtp extends OtpEvent {
  final String phoneNumber, otp;
  final bool isLogIn;
  VerifyOtp(
      {required this.phoneNumber, required this.otp, required this.isLogIn});
  @override
  List<Object> get props => [phoneNumber, otp, isLogIn];
}
