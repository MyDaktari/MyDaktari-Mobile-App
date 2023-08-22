import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../repositories/shared_repositories/shop/shop_repository.dart';

part 'shop_payment_event.dart';
part 'shop_payment_state.dart';

class ShopPaymentBloc extends Bloc<ShopPaymentEvent, ShopPaymentState> {
  final ShopRepository _paymentRepository;
  ShopPaymentBloc({required ShopRepository repository})
      : _paymentRepository = repository,
        super(PaymentInitial()) {
    on<MakeShopPayment>(_onMakeShopPayment);
  }
  void _onMakeShopPayment(
      MakeShopPayment event, Emitter<ShopPaymentState> emit) async {
    try {
      emit(PaymentLoading());
      String paymentResponse = await _paymentRepository.makePayment(
          amount: event.amount,
          appointmentID: event.appointmentID,
          phoneNumber: event.userPhoneNumber);
      emit(PaymentSuccess(successMessage: paymentResponse));
    } catch (error) {
      final message = error.toString().contains("host lookup")
          ? 'Connect to the internet '
          : error.toString().split("Exception:").last;
      emit(PaymentFailure(errorMessage: message));
    }
  }
}
