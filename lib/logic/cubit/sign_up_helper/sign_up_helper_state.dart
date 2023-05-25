part of 'sign_up_helper_cubit.dart';

class SignUpHelperState extends Equatable {
  final bool termsAccepted;
  final String birthDate;
  final Sex sex;

  SignUpHelperState({
    required this.termsAccepted,
    required this.birthDate,
    required this.sex,
  });
  SignUpHelperState copyWith({
    bool? termsAccepted,
    String? birthDate,
    Sex? sex,
  }) {
    return SignUpHelperState(
      termsAccepted: termsAccepted ?? this.termsAccepted,
      birthDate: birthDate ?? this.birthDate,
      sex: sex ?? this.sex,
    );
  }

  @override
  List<Object> get props => [termsAccepted, birthDate, sex];
}
