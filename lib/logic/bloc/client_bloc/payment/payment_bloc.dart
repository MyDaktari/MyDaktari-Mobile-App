import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/repositories/client/client_repository.dart';

part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final ClientRepository _paymentRepository;
  PaymentBloc({required ClientRepository repository})
      : _paymentRepository = repository,
        super(PaymentInitial()) {
    on<MakePayment>(_onMakePayment);
  }
  void _onMakePayment(MakePayment event, Emitter<PaymentState> emit) async {
    try {
      emit(PaymentLoading());
      String paymentResponse = await _paymentRepository.makePayment(
          amount: event.amount,
          appointmentID: event.appointmentID,
          phoneNumber: event.userPhoneNumber);
      emit(PaymentSuccess(successMessage: paymentResponse));
    } catch (e) {
      emit(
          const PaymentFailure(errorMessage: 'Payment Could not be completed'));
    }
  }
}
