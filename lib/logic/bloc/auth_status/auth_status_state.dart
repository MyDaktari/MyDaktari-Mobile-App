part of 'auth_status_bloc.dart';

abstract class AuthStatusState extends Equatable {
  const AuthStatusState();
  
  @override
  List<Object> get props => [];
}

class AuthStatusInitial extends AuthStatusState {}
