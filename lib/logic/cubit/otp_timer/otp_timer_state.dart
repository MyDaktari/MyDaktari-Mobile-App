part of 'otp_timer_cubit.dart';

class OtpTimerState extends Equatable {
  final int counter;
  final bool isLongIn;

  const OtpTimerState({required this.counter, required this.isLongIn});

  OtpTimerState copyWith({int? counter, bool? isLogIn}) {
    return OtpTimerState(
      isLongIn: isLogIn ?? this.isLongIn,
      counter: counter ?? this.counter,
    );
  }

  @override
  List<Object?> get props => [counter, isLongIn];
}
