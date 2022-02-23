import 'package:brilloapp/config/Helpers/constants.dart';
import 'package:brilloapp/config/blocs/bloc/auth_bloc/auth_bloc.dart';
import 'package:brilloapp/screens/login_screen.dart';
import 'package:brilloapp/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class ForgotPassword extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  static const routeName = '/forgotpassword';

  ForgotPassword() : super();
  AuthBloc? authBloc;

  @override
  Widget build(BuildContext context) {
    authBloc = BlocProvider.of<AuthBloc>(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        //here too
        body: Column(
          children: [
            const _CustomCurvedBar(),
            //Exapded e4 sigle child
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 40,
                    right: 40,
                    bottom: 40,
                  ),
                  child: FormBuilder(
                    key: _formKey,
                    //here too
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            horizontalSpacer(10),
                            Icon(
                              Icons.data_usage,
                              color: Colors.grey[500],
                              size: 18,
                            ),
                            horizontalSpacer(10),
                            Expanded(
                              child: Text(
                                'Don\'t panic, Your password reset link will be sent to your mail',
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                        vericalSpacer(20),
                        customFormBuilderTextField(
                          'email',
                          Icons.email,
                          null,
                          'Your Email address',
                          validator: FormBuilderValidators.compose(
                            [
                              FormBuilderValidators.email(context,
                                  errorText: 'Provided email not valid '),
                              FormBuilderValidators.required(context,
                                  errorText: 'Email field cannot be empty '),
                            ],
                          ),
                        ),
                        vericalSpacer(100),
                        CustomButton(
                          child: const Text(
                            'Confirm',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                          formKey: _formKey,
                          onPressed: () {
                            var validate = _formKey.currentState?.validate();
                            if (validate == true) {
                              _formKey.currentState?.save();
                              var email =
                                  _formKey.currentState?.fields['email']?.value;
                              authBloc?.add(ForgotPasswordButtonPressed(email));
                            }
                          },
                        ),
                        vericalSpacer(100),
                        BlocListener<AuthBloc, AuthState>(
                          listener: ((context, state) {
                            if (state is PasswordResetSuccessful) {
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.routeName);
                              ScaffoldMessenger.of(context)
                                ..removeCurrentSnackBar()
                                ..showSnackBar(const SnackBar(
                                  content: Text(
                                      'Password Reset Link Has Been Sent to Your Mail '),
                                  backgroundColor: Colors.red,
                                ));
                            }
                          }),
                          child: BlocBuilder<AuthBloc, AuthState>(
                              builder: ((context, state) {
                            if (state is PasswordResetInProgress) {
                              return const CircularProgressIndicator();
                            } else if (state is PasswordResetFailed) {
                              return Text(state.message);
                            } else if (state is PasswordResetSuccessful) {
                              return Container();
                            }

                            return Container();
                          })),
                        ),
                        CustomWhiteButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.routeName);
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.logout),
                                horizontalSpacer(10),
                                Text('Cancel')
                              ],
                            ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
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
            height: 210,
            decoration: const BoxDecoration(color: Colors.purple),
          ),
        ),
        ClipPath(
          clipper: WaveClipper(),
          child: Container(
            height: 200,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.purple, Colors.pink],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 70, left: 50),
              child: Row(
                children: [
                  Text(
                    'Retrive Your Forgotten Password',
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  vericalSpacer(10),
                  const Icon(Icons.insert_emoticon)
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
    var path = Path();
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
