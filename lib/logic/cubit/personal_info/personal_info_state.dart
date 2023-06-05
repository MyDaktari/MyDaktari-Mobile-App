part of 'personal_info_cubit.dart';

class PersonalInfoState extends Equatable {
  final String specialty, careerOverview;
  final int experience;
  final String location;
  final PlatformFile profilePicture, nationalId;
  PersonalInfoState({
    required this.specialty,
    required this.experience,
    required this.careerOverview,
    required this.location,
    required this.nationalId,
    required this.profilePicture,
  });
  PersonalInfoState copyWith({
    String? specialty,
    String? carrerOverview,
    int? experience,
    String? location,
    PlatformFile? profilePicture,
    PlatformFile? nationalId,
  }) {
    return PersonalInfoState(
        specialty: specialty ?? this.specialty,
        experience: experience ?? this.experience,
        careerOverview: carrerOverview ?? this.careerOverview,
        location: location ?? this.location,
        nationalId: nationalId ?? this.nationalId,
        profilePicture: profilePicture ?? this.profilePicture);
  }

  @override
  List<Object> get props => [
        specialty,
        experience,
        careerOverview,
        location,
        nationalId,
        profilePicture
      ];
}
