import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';

import '../personal_info/personal_info_cubit.dart';

class PersonalInfoCubit extends Cubit<PersonalInfoState> {
  PersonalInfoCubit()
      : super(PersonalInfoState(
            title: '',
            careerOverview: '',
            experience: 0,
            location: '',
            specialty: '',
            nationalId: PlatformFile(name: '', size: 0),
            profilePicture: PlatformFile(name: '', size: 0)));

  void updatePersonalInfo({
    required String title,
    required String specialty,
    required String careerOverview,
    required String location,
    required int experience,
  }) {
    emit(state.copyWith(
        title: title,
        specialty: specialty,
        carrerOverview: careerOverview,
        experience: experience,
        location: location));
  }

  void updatePersonalFile(
      {PlatformFile? profilePicture, PlatformFile? nationalId}) {
    emit(state.copyWith(
      profilePicture: profilePicture,
      nationalId: nationalId,
    ));
  }
}
