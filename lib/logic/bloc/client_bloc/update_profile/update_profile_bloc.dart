// ignore_for_file: unused_local_variable

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_daktari/constants/constants.dart';

import '../../../../repositories/shared_repositories/profile/profile_repository.dart';

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
      emit(UpdateProfileLoading());
      String response = await repo.updateClientProfile(
          userId: event.userId,
          name: event.name,
          dob: event.dob,
          gender: event.gender,
          phoneNumber: event.phoneNumber,
          profilePicture: event.profilePicture);
      client = await repo.getClientModelFromLocalStorage();
      emit(UpdateProfileLoaded());
    } catch (error) {
      final message = error.toString().contains("host lookup")
          ? 'Connect to the internet '
          : error.toString().split("Exception:").last;
      emit(UpdateProfileLoadError(message: message));
    }
  }

  void _onUpdateDoctorProfile(
      UpdateDoctorProfile event, Emitter<UpdateProfileState> emit) async {
    try {
      emit(UpdateProfileLoading());
      String response = await repo.updateDoctorProfile(
          userId: event.userId,
          name: event.name,
          dob: event.dob,
          gender: event.gender,
          phoneNumber: event.phoneNumber,
          profilePicture: event.profilePicture);
      doctor = await repo.getDoctorModelFromLocalStorage();
      emit(UpdateProfileLoaded());
    } catch (error) {
      final message = error.toString().contains("host lookup")
          ? 'Connect to the internet '
          : error.toString().split("Exception:").last;
      emit(UpdateProfileLoadError(message: message));
    }
  }
}
