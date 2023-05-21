import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_status_event.dart';
part 'auth_status_state.dart';

class AuthStatusBloc extends Bloc<AuthStatusEvent, AuthStatusState> {
  AuthStatusBloc() : super(AuthStatusInitial()) {
    on<AuthStatusEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
