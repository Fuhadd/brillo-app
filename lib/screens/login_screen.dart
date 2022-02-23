import 'package:brilloapp/config/Helpers/constants.dart';
import 'package:brilloapp/config/blocs/bloc/login_bloc/login_bloc.dart';
import 'package:brilloapp/config/repositories/user_repository.dart';
import 'package:brilloapp/screens/forgot_password_screen.dart';
import 'package:brilloapp/screens/home_screen.dart';
import 'package:brilloapp/screens/signup_screen.dart';
import 'package:brilloapp/screens/verification_screen.dart';
import 'package:brilloapp/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  static const routeName = '/login';

  LoginScreen({Key? key}) : super(key: key);
  LoginBloc? loginBloc;

  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository();
    loginBloc = BlocProvider.of<LoginBloc>(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const _CustomCurvedBar(),
              Padding(
                padding: const EdgeInsets.only(
                  left: 40,
                  right: 40,
                  bottom: 40,
                ),
                child: FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      vericalSpacer(20),
                      customFormBuilderTextField(
                        'email',
                        Icons.mail,
                        null,
                        'Email',
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.email(context,
                                errorText: 'Provided email not valid '),
                            FormBuilderValidators.required(context,
                                errorText: 'Email field cannot be empty '),
                          ],
                        ),
                      ),
                      vericalSpacer(25),
                      customFormBuilderTextField(
                        'password',
                        Icons.vpn_key,
                        Icons.no_encryption_gmailerrorred_outlined,
                        'Password',
                        obscureText: true,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.minLength(context, 6,
                              errorText:
                                  'Good passwords are greater than 6 characters'),
                          FormBuilderValidators.required(context,
                              errorText: 'Password field cannot be empty '),
                        ]),
                      ),
                      vericalSpacer(15),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, ForgotPassword.routeName);
                        },
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Forget Password ?',
                            textAlign: TextAlign.right,
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(color: Colors.grey[700]),
                          ),
                        ),
                      ),
                      vericalSpacer(20),
                      CustomButton(
                        formKey: _formKey,
                        onPressed: () {
                          bool? validate = _formKey.currentState?.validate();
                          print(validate);
                          if (validate == true) {
                            _formKey.currentState?.save();

                            var email =
                                _formKey.currentState?.fields['email']?.value;
                            var password = _formKey
                                .currentState?.fields['password']?.value;
                            loginBloc?.add(LoginButtonPressed(
                                email: email, password: password));
                          }
                        },
                        child: Text('Login',
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(color: Colors.white)),
                      ),
                      vericalSpacer(20),
                      BlocListener<LoginBloc, LoginState>(
                        listener: (context, state) {
                          if (state is LoginSuccessful) {
                            Navigator.of(context).pop();
                            Navigator.pushReplacementNamed(
                                context, VerifyEmailScreen.routeName);
                            // Navigator.popUntil(
                            //     context, (route) => HomeScreen.routeName);
                          }
                        },
                        child: BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            if (state is LoginInProgress) {
                              Future.delayed(Duration.zero, () {
                                showdialog(context);
                              });

                              // return Container(child: loader());
                            } else if (state is LoginFailed) {
                              Future.delayed(Duration.zero, () {
                                Navigator.of(context).pop();
                                ScaffoldMessenger.of(context)
                                  ..removeCurrentSnackBar()
                                  ..showSnackBar(SnackBar(
                                    content: Text(state.message),
                                    backgroundColor: Colors.red,
                                  ));
                              });

                              // WidgetsBinding.instance
                              //     ?.addPostFrameCallback((_) {
                              // ScaffoldMessenger.of(context)
                              //   ..removeCurrentSnackBar()
                              //   ..showSnackBar(SnackBar(
                              //     content: Text(state.message),
                              //     backgroundColor: Colors.red,
                              //   ));

                              // Add Your Code here.
                              // });

                              // return Text(state.message);
                            } else if (state is LoginSuccessful) {
                              Container();
                            }

                            return Container();
                          },
                        ),
                      ),
                      vericalSpacer(20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an Account ?'),
                          TextButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, SignUpScreen.routeName);
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.pink,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class _CustomCurvedBar extends StatelessWidget {
  const _CustomCurvedBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        ClipPath(
          clipper: WaveClipper(),
          child: Container(
            height: 250,
            decoration: BoxDecoration(color: Colors.pink),
          ),
        ),
        ClipPath(
          clipper: WaveClipper(),
          child: Container(
            height: 240,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: const [Colors.pink, Colors.purple],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 55, left: 40),
              child: Row(
                children: [
                  Text(
                    'Welcome Back',
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0, size.height);
    var firstController = Offset(0, size.height - 90);
    var firstEnd = Offset(size.width / 4, size.height - 90);
    path.quadraticBezierTo(
      firstController.dx,
      firstController.dy,
      firstEnd.dx,
      firstEnd.dy,
    );
    path.lineTo(size.width - 100, size.height - 90);
    var SecondController = Offset(size.width - 55, size.height - 90);
    var SecondEnd = Offset(size.width, size.height - 140);
    path.quadraticBezierTo(
      SecondController.dx,
      SecondController.dy,
      SecondEnd.dx,
      SecondEnd.dy,
    );
    path.lineTo(size.width, 0);
    path.close;
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }
}
