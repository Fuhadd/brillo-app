import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:brilloapp/config/repositories/user_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  UserRepository userRepository;
  LoginBloc(this.userRepository) : super(LoginInitial()) {
    on<LoginButtonPressed>(_handleLoginProcess);
  }

  FutureOr<void> _handleLoginProcess(
      LoginButtonPressed event, Emitter<LoginState> emit) async {
    try {
      emit(LoginInProgress());
      User? user =
          await userRepository.LoginWithEmail(event.email, event.password);
      emit(
        LoginSuccessful(user),
      );
    } catch (error) {
      emit(LoginFailed(error.toString()));
    }
  }
}
