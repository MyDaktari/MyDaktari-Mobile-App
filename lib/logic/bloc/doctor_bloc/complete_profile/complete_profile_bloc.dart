import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/repositories/doctor/doctor_repository.dart';

part 'complete_profile_event.dart';
part 'complete_profile_state.dart';

class CompleteProfileBloc
    extends Bloc<CompleteProfileEvent, CompleteProfileState> {
  final DoctorRepository doctorRepository;
  CompleteProfileBloc({required DoctorRepository doctorRepository})
      : doctorRepository = doctorRepository,
        super(CompleteProfileInitial()) {
    on<DoctorUpdateProfile>(_onDoctorUpdateProfile);
  }
  void _onDoctorUpdateProfile(
      DoctorUpdateProfile event, Emitter<CompleteProfileState> emit) async {
    emit(CompleteProfileLoading());
    try {
      await doctorRepository.completeDoctorProfile(
        doctorId: event.doctorId,
        specialty: event.specialty,
        careerOverview: event.careerOverview,
        experience: event.experience,
        location: event.location,
        nationalId: event.nationalId,
        profilePicture: event.profilePicture,
      );
      emit(CompleteProfileLoaded());
    } catch (error) {
      emit(CompleteProfileLoadError(message: error.toString()));
    }
  }
}
