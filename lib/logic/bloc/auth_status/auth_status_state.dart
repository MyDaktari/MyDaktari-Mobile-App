part of 'auth_status_bloc.dart';

abstract class AuthStatusState extends Equatable {
  const AuthStatusState();

  @override
  List<Object> get props => [];
}

class AuthStatusLoding extends AuthStatusState {}

class UserUnauthenticated extends AuthStatusState {
  @override
  List<Object> get props => [];
}

class UserAuthenticated extends AuthStatusState {
  final dynamic user;
  final UserType userType;
  const UserAuthenticated({required this.userType, required this.user});
  @override
  List<Object> get props => [user, userType];
}

class UserAuthStatusError extends AuthStatusState {
  final String message;

  UserAuthStatusError({required this.message});
  @override
  List<Object> get props => [message];
}
