import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'booking_info_state.dart';

class BookingInfoCubit extends Cubit<BookingInfoState> {
  BookingInfoCubit()
      : super(BookingInfoState(
          date: DateTime.now(),
          description: '',
          doctorId: '',
          meetingOption: '',
          symptomID: '',
          time: '',
          userId: '',
          amount: '',
          appointmentId: '',
        ));

  void updateBookingInfo(
      {DateTime? date,
      String? time,
      String? userId,
      String? doctorId,
      String? symptomID,
      String? description,
      String? appointmentId,
      String? amount,
      String? meetingOption}) {
    emit(state.copyWith(
      symptomID: symptomID,
      description: description,
      date: date,
      amount: amount,
      appointmentId: appointmentId,
      doctorId: doctorId,
      meetingOption: meetingOption,
      time: time,
      userId: userId,
    ));
  }
}
