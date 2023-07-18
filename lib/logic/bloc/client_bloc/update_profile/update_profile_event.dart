part of 'update_profile_bloc.dart';

abstract class UpdateProfileEvent extends Equatable {
  const UpdateProfileEvent();
  @override
  List<Object> get props => [];
}

class UpdateClientProfile extends UpdateProfileEvent {
  final String userId, name, dob, gender, phoneNumber;
  final File profilePicture;
  const UpdateClientProfile(
      {required this.userId,
      required this.name,
      required this.dob,
      required this.gender,
      required this.phoneNumber,
      required this.profilePicture});
  @override
  List<Object> get props =>
      [userId, name, dob, gender, phoneNumber, profilePicture];
}

class UpdateDoctorProfile extends UpdateProfileEvent {
  final String userId, name, dob, gender, phoneNumber;
  final PlatformFile profilePicture;
  const UpdateDoctorProfile(
      {required this.userId,
      required this.name,
      required this.dob,
      required this.phoneNumber,
      required this.gender,
      required this.profilePicture});
  @override
  List<Object> get props =>
      [userId, name, dob, gender, phoneNumber, profilePicture];
}
