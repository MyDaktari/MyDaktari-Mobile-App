part of 'booking_info_cubit.dart';

class BookingInfoState extends Equatable {
  final String time,
      userId,
      doctorId,
      symptomID,
      description,
      meetingOption,
      appointmentId,
      amount;
  final DateTime date;
  BookingInfoState({
    required this.date,
    required this.time,
    required this.appointmentId,
    required this.amount,
    required this.userId,
    required this.doctorId,
    required this.description,
    required this.meetingOption,
    required this.symptomID,
  });
  BookingInfoState copyWith(
      {DateTime? date,
      String? time,
      String? userId,
      String? appointmentId,
      String? amount,
      String? doctorId,
      String? symptomID,
      String? description,
      String? meetingOption}) {
    return BookingInfoState(
        amount: amount ?? this.amount,
        appointmentId: appointmentId ?? this.appointmentId,
        date: date ?? this.date,
        description: description ?? this.description,
        doctorId: doctorId ?? this.doctorId,
        meetingOption: meetingOption ?? this.meetingOption,
        symptomID: symptomID ?? this.symptomID,
        time: time ?? this.time,
        userId: userId ?? this.userId);
  }

  @override
  List<Object> get props => [
        date,
        time,
        userId,
        doctorId,
        symptomID,
        description,
        meetingOption,
        amount,
        appointmentId
      ];
}
