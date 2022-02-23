import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:brilloapp/config/repositories/firestore_repository.dart';
import 'package:brilloapp/config/repositories/user_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  UserRepository userRepository;
  FirestoreRepository firestoreRepository;
  SignupBloc(this.userRepository, this.firestoreRepository)
      : super(SignupInitial()) {
    on<SignUpButtonPressed>(_handleUserSignup);
  }

  FutureOr<void> _handleUserSignup(
      SignUpButtonPressed event, Emitter<SignupState> emit) async {
    try {
      emit(SignupInProgress());
      User? user =
          await userRepository.CreateUserWithEmail(event.email, event.password);
      if (user != null) {
        await firestoreRepository.saveUserCredentials(
          event.userName,
          event.email,
          event.phone,
          event.gender,
        );
        emit(SignupSuccessful(user));
      }
    } catch (error) {
      emit(SignupFailed(error.toString()));
    }
  }
}
