import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../repositories/profile/profile_repository.dart';

part 'update_profile_event.dart';
part 'update_profile_state.dart';

class UpdateProfileBloc extends Bloc<UpdateProfileEvent, UpdateProfileState> {
  final ProfileRepository repo;
  UpdateProfileBloc({required ProfileRepository repository})
      : repo = repository,
        super(UpdateProfileInitial()) {
    on<UpdateClientProfile>(_onUpdateClientProfile);
    on<UpdateDoctorProfile>(_onUpdateDoctorProfile);
  }
  Future<void> _onUpdateClientProfile(
      UpdateClientProfile event, Emitter<UpdateProfileState> emit) async {
    try {
      String response = await repo.updateClientProfile(
          userId: event.userId,
          name: event.name,
          dob: event.dob,
          gender: event.gender,
          phoneNumber: event.phoneNumber,
          profilePicture: event.profilePicture);
      emit(UpdateProfileLoaded());
    } catch (error) {
      emit(UpdateProfileLoadError(message: error.toString()));
    }
  }

  void _onUpdateDoctorProfile(
      UpdateDoctorProfile event, Emitter<UpdateProfileState> emit) async {
    try {
      String response = await repo.updateDoctorProfile(
          userId: event.userId,
          name: event.name,
          dob: event.dob,
          gender: event.gender,
          phoneNumber: event.phoneNumber,
          profilePicture: event.profilePicture);
      emit(UpdateProfileLoaded());
    } catch (error) {
      emit(UpdateProfileLoadError(message: error.toString()));
    }
  }
}