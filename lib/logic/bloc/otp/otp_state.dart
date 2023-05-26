part of 'otp_bloc.dart';

abstract class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object> get props => [];
}

class OtpInitalize extends OtpState {}

class OtpLoading extends OtpState {}

class OtpLoaded extends OtpState {}

class OtpSet extends OtpState {}

class OtpLoadingError extends OtpState {
  final String errorMessage;
  OtpLoadingError({required this.errorMessage});
  @override
  List<Object> get props => [errorMessage];
}
