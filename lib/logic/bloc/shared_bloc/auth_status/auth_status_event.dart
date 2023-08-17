// ignore_for_file: must_be_immutable

part of 'auth_status_bloc.dart';

abstract class AuthStatusEvent extends Equatable {
  const AuthStatusEvent();

  @override
  List<Object> get props => [];
}

class CheckUserStatus extends AuthStatusEvent {
  bool showMessage;
  CheckUserStatus({this.showMessage = false});
  @override
  List<Object> get props => [showMessage];
}

class logUserOut extends AuthStatusEvent {}
