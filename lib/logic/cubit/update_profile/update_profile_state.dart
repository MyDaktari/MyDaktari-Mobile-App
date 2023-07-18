part of 'update_profile_cubit.dart';

class UpdateProfileCState extends Equatable {
  final String birthDate;
  final Sex sex;

  UpdateProfileCState({
    required this.birthDate,
    required this.sex,
  });
  UpdateProfileCState copyWith(
      {bool? termsAccepted, String? birthDate, Sex? sex}) {
    return UpdateProfileCState(
        birthDate: birthDate ?? this.birthDate, sex: sex ?? this.sex);
  }

  @override
  List<Object> get props => [birthDate, sex];
}
