part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

//Doctor events
class RegisterDoctor extends AuthenticationEvent {
  final String name, password, phone, dob, gender, email;
  RegisterDoctor(
      {required this.name,
      required this.password,
      required this.phone,
      required this.dob,
      required this.gender,
      required this.email});
  List<Object> get props => [name, password, phone, dob, gender, email];
}

class LoginUser extends AuthenticationEvent {
  final String username, password;
  final UserType userType;
  const LoginUser(
      {required this.userType, required this.username, required this.password});
  @override
  List<Object> get props => [username, password];
}

//Client events
class RegisterClient extends AuthenticationEvent {
  final String name, password, phone, dob, gender, email, address;
  RegisterClient(
      {required this.name,
      required this.password,
      required this.phone,
      required this.dob,
      required this.gender,
      required this.email,
      required this.address});
  List<Object> get props =>
      [name, password, phone, dob, gender, email, address];
}

class WelcomeUser extends AuthenticationEvent {
  final BuildContext context;
  const WelcomeUser({required this.context});
  @override
  List<Object> get props => [context];
}

class SendOTP extends AuthenticationEvent {
  final String phoneNumber;
  const SendOTP({required this.phoneNumber});
}
