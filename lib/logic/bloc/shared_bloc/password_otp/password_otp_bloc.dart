import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_daktari/constants/enums.dart';
import 'package:my_daktari/repositories/shared_repositories/authentication/authentication_repository.dart';

part 'password_otp_event.dart';
part 'password_otp_state.dart';

class PasswordOtpBloc extends Bloc<PasswordOtpEvent, PasswordOtpState> {
  final AuthenticationRepository authenticationRepository;
  PasswordOtpBloc({required AuthenticationRepository authRepository})
      : authenticationRepository = authRepository,
        super(PasswordOtpInitalize()) {
    on<RequestPasswordOtp>(_onRequestPasswordOtp);
    on<VerifyPasswordOtp>(_onVerifyPasswordOtp);
  }
  void _onRequestPasswordOtp(
      RequestPasswordOtp event, Emitter<PasswordOtpState> emit) async {
    emit(PasswordOtpLoading());
    try {
      String message = await authenticationRepository.passwordOtpRequest(
          phoneNumber: event.phoneNumber, userType: event.userType);
      emit(PasswordOtpSet());
    } catch (error) {
      final message = error.toString().contains("host lookup")
          ? 'Connect to the internet '
          : error.toString().split("Exception:").last;
      emit(PasswordOtpLoadError(errorMessage: message));
    }
  }

  void _onVerifyPasswordOtp(
      VerifyPasswordOtp event, Emitter<PasswordOtpState> emit) async {
    emit(PasswordOtpLoading());
    try {
      String userId = await authenticationRepository.passwordOtpVerification(
          phoneNumber: event.phoneNumber, otp: event.PasswordOtp);
      emit(PasswordOtpLoaded(userId: userId));
    } catch (error) {
      String errorMessage = error.toString().contains("host lookup")
          ? 'Connect to the internet '
          : error.toString().split("Exception:").last;
      emit(PasswordOtpLoadError(errorMessage: errorMessage));
    }
  }
}
