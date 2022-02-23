part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class SignUpButtonPressed extends SignupEvent {
  String email;
  String password;
  String userName;

  String phone;
  String gender;

  SignUpButtonPressed({
    required this.email,
    required this.password,
    required this.userName,
    required this.phone,
    required this.gender,
  });

  @override
  List<Object> get props => [email, password];
}
