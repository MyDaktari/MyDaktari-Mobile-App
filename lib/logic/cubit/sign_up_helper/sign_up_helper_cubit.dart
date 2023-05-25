import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../constants/enums.dart';

part 'sign_up_helper_state.dart';

class SignUpHelperCubit extends Cubit<SignUpHelperState> {
  SignUpHelperCubit()
      : super(SignUpHelperState(
          termsAccepted: false,
          birthDate: '',
          sex: Sex.undefined,
        ));

  void updateTerms(bool termsAccepted) {
    emit(state.copyWith(termsAccepted: termsAccepted));
  }

  void updateBirthDate(String birthDate) {
    emit(state.copyWith(birthDate: birthDate));
  }

  void updateSex(Sex sex) {
    emit(state.copyWith(sex: sex));
  }
}
