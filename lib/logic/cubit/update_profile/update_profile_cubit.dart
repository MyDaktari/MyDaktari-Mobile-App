import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../constants/enums.dart';

part 'update_profile_state.dart';

class UpdateProfileCubit extends Cubit<UpdateProfileCState> {
  UpdateProfileCubit()
      : super(UpdateProfileCState(
            birthDate: '', sex: Sex.undefined, imagePath: File('')));

  void updateBirthDate(String birthDate) {
    emit(state.copyWith(birthDate: birthDate));
  }

  void updateImagePath({required File imagePath}) {
    emit(state.copyWith(imagePath: imagePath));
  }

  void updateSex(Sex sex) {
    emit(state.copyWith(sex: sex));
  }
}
