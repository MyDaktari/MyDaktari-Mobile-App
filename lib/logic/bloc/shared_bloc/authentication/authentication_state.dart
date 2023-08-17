part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationLoaded extends AuthenticationState {
  final UserType userType;
  final dynamic user;

  AuthenticationLoaded({required this.userType, required this.user});
  @override
  List<Object> get props => [user, userType];
}

class AuthenticationError extends AuthenticationState {
  final String errorMessage;
  final UserType userType;

  const AuthenticationError(
      {required this.errorMessage, required this.userType});
  @override
  List<Object> get props => [errorMessage, userType];
}
