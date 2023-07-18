import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../constants/enums.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileCState> {
  UpdateProfileCubit()
      : super(UpdateProfileCState(birthDate: '', sex: Sex.undefined));

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
