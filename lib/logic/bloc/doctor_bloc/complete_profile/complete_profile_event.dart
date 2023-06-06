part of 'complete_profile_bloc.dart';

abstract class CompleteProfileEvent extends Equatable {
  const CompleteProfileEvent();

  @override
  List<Object> get props => [];
}

class DoctorUpdateProfile extends CompleteProfileEvent {
  final String specialty, careerOverview, doctorId;
  final int experience;
  final String location;
  final PlatformFile profilePicture, nationalId;

  const DoctorUpdateProfile({
    required this.doctorId,
    required this.specialty,
    required this.experience,
    required this.careerOverview,
    required this.location,
    required this.nationalId,
    required this.profilePicture,
  });
  @override
  List<Object> get props => [
        doctorId,
        specialty,
        experience,
        careerOverview,
        location,
        nationalId,
        profilePicture
      ];
}
