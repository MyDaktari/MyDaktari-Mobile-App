import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_daktari/repositories/authentication/authentication_repository.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final AuthenticationRepository authenticationRepository;
  OtpBloc({required AuthenticationRepository authRepository})
      : authenticationRepository = authRepository,
        super(OtpInitalize()) {
    on<RequestOtp>(_onRequestOtp);
    on<VerifyOtp>(_onVerifyOtp);
  }
  void _onRequestOtp(RequestOtp event, Emitter<OtpState> emit) async {
    emit(OtpLoading());
    try {
      String message = await authenticationRepository.otpRequest(
          phoneNumber: event.phoneNumber);
      print(message);
      emit(OtpSet());
    } catch (error) {
      emit(OtpLoadingError(errorMessage: error.toString()));
    }
  }

  void _onVerifyOtp(VerifyOtp event, Emitter<OtpState> emit) async {
    emit(OtpLoading());
    try {
      String message = await authenticationRepository.otpVerification(
          phoneNumber: event.phoneNumber, otp: event.otp);
      print(message);
      emit(OtpLoaded());
    } catch (error) {
      emit(OtpLoadingError(errorMessage: error.toString()));
    }
  }
}
