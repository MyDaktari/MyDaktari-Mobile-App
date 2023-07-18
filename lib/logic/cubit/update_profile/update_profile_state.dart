part of 'update_profile_cubit.dart';

class UpdateProfileCState extends Equatable {
  final String birthDate;
  final Sex sex;
  final File imagePath;

  UpdateProfileCState(
      {required this.birthDate, required this.sex, required this.imagePath});
  UpdateProfileCState copyWith(
      {bool? termsAccepted, String? birthDate, Sex? sex, File? imagePath}) {
    return UpdateProfileCState(
        birthDate: birthDate ?? this.birthDate,
        sex: sex ?? this.sex,
        imagePath: imagePath ?? this.imagePath);
  }

  @override
  List<Object> get props => [birthDate, sex];
}
