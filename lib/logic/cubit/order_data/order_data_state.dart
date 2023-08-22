part of 'order_data_cubit.dart';

class OrderDataState extends Equatable {
  final String userId, name, phone, address, additionalInfo;

  OrderDataState({
    required this.userId,
    required this.name,
    required this.phone,
    required this.address,
    required this.additionalInfo,
  });
  OrderDataState copyWith({
    String? userId,
    String? name,
    String? phone,
    String? address,
    String? additionalInfo,
  }) {
    return OrderDataState(
        userId: userId ?? this.userId,
        name: name ?? this.name,
        phone: phone ?? this.phone,
        address: address ?? this.address,
        additionalInfo: additionalInfo ?? this.additionalInfo);
  }

  @override
  List<Object> get props => [
        userId,
        name,
        phone,
        address,
        additionalInfo,
      ];
}
