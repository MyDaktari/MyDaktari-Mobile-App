part of 'drop_down_cubit.dart';

class DropChargesState extends Equatable {
  final DropCharges chat;
  final DropCharges phone;
  final DropCharges video;

  DropChargesState(
      {required this.chat, required this.phone, required this.video});
  DropChargesState copyWith({
    DropCharges? chat,
    DropCharges? phone,
    DropCharges? video,
  }) {
    return DropChargesState(
        chat: chat ?? this.chat,
        phone: phone ?? this.phone,
        video: video ?? this.video);
  }

  @override
  List<Object> get props => [chat, phone, video];
}
