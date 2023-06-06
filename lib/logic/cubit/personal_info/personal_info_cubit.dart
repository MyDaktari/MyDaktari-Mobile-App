import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

part 'personal_info_state.dart';

class PersonalInfoCubit extends Cubit<PersonalInfoState> {
  PersonalInfoCubit()
      : super(PersonalInfoState(
            careerOverview: '',
            experience: 0,
            location: '',
            specialty: '',
            nationalId: PlatformFile(name: '', size: 0),
            profilePicture: PlatformFile(name: '', size: 0)));

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
      {PlatformFile? profilePicture, PlatformFile? nationalId}) {
    emit(state.copyWith(
      profilePicture: profilePicture,
      nationalId: nationalId,
    ));
  }
}
