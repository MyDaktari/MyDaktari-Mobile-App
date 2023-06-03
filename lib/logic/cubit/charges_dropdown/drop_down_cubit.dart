import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../constants/enums.dart';

part 'drop_down_state.dart';

class DropChargesCubit extends Cubit<DropChargesState> {
  DropChargesCubit()
      : super(DropChargesState(
          chat: DropCharges.Per_session,
          phone: DropCharges.Per_session,
          video: DropCharges.Per_session,
        ));

  void updateChatCharges(DropCharges dropCharges) {
    emit(state.copyWith(chat: dropCharges));
  }

  void updateVideoCharges(DropCharges dropCharges) {
    emit(state.copyWith(video: dropCharges));
  }

  void updatePhoneCharges(DropCharges dropCharges) {
    emit(state.copyWith(phone: dropCharges));
  }
}
