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
  final bool showMessage;
  final bool profileCompleted;
  final bool fullProfileCompleted;
  final bool optVerified;
  const UserAuthenticated({
    required this.userType,
    required this.user,
    this.optVerified = false,
    this.showMessage = false,
    this.profileCompleted = false,
    this.fullProfileCompleted = false,
  });
  @override
  List<Object> get props => [
        user,
        userType,
        showMessage,
        profileCompleted,
        fullProfileCompleted,
        optVerified
      ];
}

class UserAuthStatusError extends AuthStatusState {
  final String message;

  UserAuthStatusError({required this.message});
  @override
  List<Object> get props => [message];
}
