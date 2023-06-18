// ignore_for_file: sdk_version_since

import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_daktari/constants/constants.dart';
import 'package:my_daktari/constants/enums.dart';
import 'package:my_daktari/presentations/doctor_side/schedule/models/dayschedule.dart';

import '../../../models/models.dart';
import '../../../repositories/authentication/authentication_repository.dart';

part 'auth_status_event.dart';
part 'auth_status_state.dart';

class AuthStatusBloc extends Bloc<AuthStatusEvent, AuthStatusState> {
  final AuthenticationRepository authRepository;
  AuthStatusBloc({required AuthenticationRepository authRepository})
      : authRepository = authRepository,
        super(AuthStatusLoding()) {
    on<CheckUserStatus>(_onCheckUserStatus);
    on<logUserOut>(_onlogUserOut);
  }
  void _onCheckUserStatus(
      CheckUserStatus event, Emitter<AuthStatusState> emit) async {
    emit(AuthStatusLoding());
    bool profileCompleted = false;
    bool fullProfileCompleted = false;
    try {
      Map<String, dynamic> response = await authRepository.checkUser();

      if (response['user'] != null && response['userType'] != null) {
        //if user is a client
        if (response['userType'] == UserType.client) {
          userId = (response['user'] as ClientModel).userID.toString();
          print(userId);
          userPhoneNumber = (response['user'] as ClientModel).phone.toString();
          emit(UserAuthenticated(
              user: response['user'], userType: response['userType']));
        } else {
          //if user is a docotr
          try {
            userId = (response['user'] as DoctorModel).id.toString();
            doctor = response['user'] as DoctorModel;
            profileCompleted =
                bool.parse(response['profileCompleted'] ?? 'false');
            fullProfileCompleted =
                bool.parse(response['fullProfileCompleted'] ?? 'false');
            userPhoneNumber =
                (response['user'] as DoctorModel).phone.toString();
            //get the doctor schedule availability from shared preferencea, then convert it back to Schedules models.
            if (response['doctorSchedule'] != null) {
              schedulesConstant = availabilityToSchedules(
                  jsonDecode(response['doctorSchedule']));
            }
          } catch (e) {
            print("Error: ${e.toString()}");
          }
          emit(UserAuthenticated(
              user: response['user'],
              userType: response['userType'],
              profileCompleted: profileCompleted,
              fullProfileCompleted: fullProfileCompleted));
        }
      } else {
        print('4');
        userId = '';
        emit(UserUnauthenticated());
      }
    } catch (error) {
      userId = '';
      emit(UserUnauthenticated());
    }
  }

  void _onlogUserOut(logUserOut event, Emitter<AuthStatusState> emit) async {
    emit(AuthStatusLoding());
    try {
      bool response = await authRepository.logOut();
      if (response) emit(UserUnauthenticated());
    } catch (error) {
      emit(UserAuthStatusError(message: 'We could not log you out, Try again'));
    }
  }
}
