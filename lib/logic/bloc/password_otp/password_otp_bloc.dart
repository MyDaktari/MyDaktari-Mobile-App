import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_daktari/constants/enums.dart';
import 'package:my_daktari/repositories/authentication/authentication_repository.dart';

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
      emit(PasswordOtpLoadError(errorMessage: error.toString()));
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
      String errorMessage = error.toString().split(':').last;
      emit(PasswordOtpLoadError(errorMessage: errorMessage));
    }
  }
}
