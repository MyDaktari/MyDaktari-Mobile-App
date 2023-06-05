import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'personal_info_state.dart';

class PersonalInfoCubit extends Cubit<PersonalInfoState> {
  PersonalInfoCubit()
      : super(PersonalInfoState(
            careerOverview: '',
            experience: 0,
            location: '',
            specialty: '',
            nationalId: File(''),
            profilePicture: File('')));

  void updatePersonalInfo({
    required String specialty,
    required String careerOverview,
    required String location,
    required int experience,
  }) {
    emit(state.copyWith(
        specialty: specialty,
        carrerOverview: careerOverview,
        experience: experience,
        location: location));
  }

  void updatePersonalFile(
      {required File profilePicture, required File nationalId}) {
    emit(
        state.copyWith(profilePicture: profilePicture, nationalId: nationalId));
  }
}
