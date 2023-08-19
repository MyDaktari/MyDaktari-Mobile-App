import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_daktari/repositories/shared_repositories/authentication/authentication_repository.dart';

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
      final message = error.toString().contains("host lookup")
          ? 'Connect to the internet '
          : error.toString().split("Exception:").last;
      emit(OtpLoadingError(errorMessage: message));
    }
  }

  void _onVerifyOtp(VerifyOtp event, Emitter<OtpState> emit) async {
    emit(OtpLoading());
    try {
      print(event.isLogIn);
      print(event.phoneNumber);
      String message = await authenticationRepository.otpVerification(
          phoneNumber: event.phoneNumber,
          otp: event.otp,
          isLogIn: event.isLogIn);
      print(message);
      emit(OtpLoaded());
    } catch (error) {
      String errorMessage = error.toString().contains("host lookup")
          ? 'Connect to the internet '
          : error.toString().split("Exception:").last;
      emit(OtpLoadingError(errorMessage: errorMessage));
    }
  }
}
