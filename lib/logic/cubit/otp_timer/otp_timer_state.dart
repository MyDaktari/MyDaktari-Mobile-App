part of 'otp_timer_cubit.dart';

class OtpTimerState extends Equatable {
  final int counter;

  const OtpTimerState({required this.counter});

  OtpTimerState copyWith({int? counter}) {
    return OtpTimerState(
      counter: counter ?? this.counter,
    );
  }

  @override
  List<Object?> get props => [counter];
}
