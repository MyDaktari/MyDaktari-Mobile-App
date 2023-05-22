part of 'user_type_cubit.dart';

class UserTypeState extends Equatable {
  final UserType userType;
  const UserTypeState({required this.userType});

  @override
  List<Object> get props => [userType];
}
