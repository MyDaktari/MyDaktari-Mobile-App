import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'otp_timer_state.dart';

class OtpTimerCubit extends Cubit<OtpTimerState> {
  Timer? _timer;

  OtpTimerCubit() : super(OtpTimerState(counter: 0, isLongIn: true));

  void startTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
    }

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.counter > 0) {
        emit(state.copyWith(counter: state.counter - 1));
      } else {
        _timer!.cancel();
      }
    });
  }

  void updateLoginStatus(bool isLongIn) {
    emit(state.copyWith(isLogIn: isLongIn));
  }

  void resetTimer() {
    emit(state.copyWith(counter: 60));
    _timer!.cancel();
  }

  @override
  Future<void> close() {
    _timer?.cancel();
    return super.close();
  }
}
