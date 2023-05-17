part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

//Doctor events
class RegisterDoctor extends AuthenticationEvent {}

class LoginDoctor extends AuthenticationEvent {
  final String username, password;
  const LoginDoctor({required this.username, required this.password});
  @override
  List<Object> get props => [username, password];
}

//Client events
class RegisterClient extends AuthenticationEvent {}

class LoginClient extends AuthenticationEvent {
  final String username, password;
  const LoginClient({required this.username, required this.password});
  @override
  List<Object> get props => [username, password];
}

class SendOTP extends AuthenticationEvent {
  final String phoneNumber;
  const SendOTP({required this.phoneNumber});
}
