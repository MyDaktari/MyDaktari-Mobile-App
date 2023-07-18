import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_daktari/constants/enums.dart';
import 'package:my_daktari/presentations/auth/widgets/welcome_dialog.dart';

import '../../../models/models.dart';
import '../../../repositories/authentication/authentication_repository.dart';
import '../../cubit/user_type/user_type_cubit.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository _repository;
  final UserTypeCubit userTypeCubit;

  AuthenticationBloc(
      {required AuthenticationRepository repository,
      required UserTypeCubit userTypeCubit})
      : _repository = repository,
        userTypeCubit = userTypeCubit,
        super(AuthenticationInitial()) {
    on<RegisterClient>(_onRegisterClient);
    on<RegisterDoctor>(_onRegisterDoctor);
    on<LoginUser>(_onLoginUser);
    on<WelcomeUser>(_onWelcomeClient);
  }

  void _onWelcomeClient(
      WelcomeUser event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      print('Hello delay');
      //await Future.delayed(Duration(seconds: 2));
      welcomeDialog(event.context);
      // Your function's code after the delay
    } catch (error) {
      String errorMessage = error.toString().split(':').last;
      emit(AuthenticationError(
          errorMessage: errorMessage, userType: userTypeCubit.state.userType));
    }
  }

  void _onRegisterClient(
      RegisterClient event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());

    try {
      ClientModel client = await _repository.registerClient(
          name: event.name,
          email: event.email,
          dob: event.dob,
          gender: event.gender,
          address: event.address,
          phone: event.phone,
          password: event.password);
      emit(AuthenticationLoaded(
          userType: userTypeCubit.state.userType, user: client));
    } catch (error) {
      String errorMessage = error.toString().split(':').last;
      emit(AuthenticationError(
          errorMessage: errorMessage, userType: userTypeCubit.state.userType));
    }
  }

  void _onRegisterDoctor(
      RegisterDoctor event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      DoctorModel doctor = await _repository.registerDoctor(
          name: event.name,
          email: event.email,
          dob: event.dob,
          gender: event.gender,
          password: event.password,
          phone: event.phone);
      emit(AuthenticationLoaded(
          userType: userTypeCubit.state.userType, user: doctor));
    } catch (error) {
      String errorMessage = error.toString().split(':').last;
      emit(AuthenticationError(
          errorMessage: errorMessage, userType: userTypeCubit.state.userType));
    }
  }

  void _onLoginUser(LoginUser event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationLoading());
    try {
      if (event.userType == UserType.client) {
        ClientModel client = await _repository.loginClient(
            username: event.username, password: event.password);
        emit(AuthenticationLoaded(
            userType: userTypeCubit.state.userType, user: client));
      } else if (event.userType == UserType.doctor) {
        DoctorModel doctor = await _repository.loginDoctor(
            username: event.username, password: event.password);
        emit(AuthenticationLoaded(
            userType: userTypeCubit.state.userType, user: doctor));
      } else {
        emit(AuthenticationError(
            errorMessage: 'User Type not defined',
            userType: userTypeCubit.state.userType));
      }
    } catch (error) {
      String errorMessage = error.toString().split(':').last;
      emit(AuthenticationError(
          errorMessage: errorMessage, userType: userTypeCubit.state.userType));
    }
  }
}
