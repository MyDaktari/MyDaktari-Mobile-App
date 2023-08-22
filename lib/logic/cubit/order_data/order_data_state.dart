part of 'order_data_cubit.dart';

class OrderDataState extends Equatable {
  final String userId, name, phone, address, additionalInfo, totalAmount;
  final List<SubOrdersModel> cartItems;

  OrderDataState({
    required this.userId,
    required this.name,
    required this.phone,
    required this.address,
    required this.additionalInfo,
    required this.cartItems,
    required this.totalAmount,
  });
  OrderDataState copyWith({
    String? userId,
    String? name,
    String? phone,
    String? address,
    String? additionalInfo,
    String? totalAmount,
    List<SubOrdersModel>? cartItems,
  }) {
    return OrderDataState(
      userId: userId ?? this.userId,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      additionalInfo: additionalInfo ?? this.additionalInfo,
      totalAmount: totalAmount ?? this.totalAmount,
      cartItems: cartItems ?? this.cartItems,
    );
  }

  @override
  List<Object> get props => [
        userId,
        name,
        phone,
        address,
        additionalInfo,
        totalAmount,
        cartItems,
      ];
}
