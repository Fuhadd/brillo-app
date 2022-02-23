import 'package:brilloapp/config/Helpers/constants.dart';
import 'package:brilloapp/config/blocs/bloc/signup_bloc/signup_bloc.dart';

import 'package:brilloapp/screens/login_screen.dart';
import 'package:brilloapp/screens/signup_second_screen.dart';
import 'package:brilloapp/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
//import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class TestScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();

  final TextEditingController phoneController = TextEditingController();
  // String initialCountry = 'NG';
  // PhoneNumber number = PhoneNumber(isoCode: 'NG');

  static const routeName = '/test';

  TestScreen({Key? key}) : super(key: key);
  SignupBloc? signupBloc;

  @override
  Widget build(BuildContext context) {
    //var phoneNumber;
    signupBloc = BlocProvider.of<SignupBloc>(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  const _CustomCurvedBar(),
                  Positioned(
                    top: 140,
                    left: MediaQuery.of(context).size.width - 330,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Already have an account ?'),
                        horizontalSpacer(10),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                                context, LoginScreen.routeName);
                          },
                          child: const Text(
                            'Login Here',
                            style: TextStyle(
                                color: Colors.pink,
                                fontWeight: FontWeight.bold,
                                fontSize: 18),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
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
                      customFormBuilderTextField(
                        'username',
                        Icons.person,
                        null,
                        'User Name',
                        validator: FormBuilderValidators.compose(
                          [
                            FormBuilderValidators.minLength(context, 4,
                                errorText:
                                    'A valid username should be greater than 4 characters '),
                          ],
                        ),
                      ),
                      vericalSpacer(25),
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
                      IntlPhoneField(
                        controller: phoneController,
                        decoration:
                            customFormDecoration('Phone Number', null, null),
                        initialCountryCode: 'NG',
                        onChanged: (phone) {
                          // phoneNumber = phone.completeNumber;
                        },
                      ),
                      customFormBuilderDropdown(
                        'gender',
                        Icons.people_outlined,
                        null,
                        'Gender',
                        items: genderOptions
                            .map((gender) => DropdownMenuItem(
                                  value: gender,
                                  child: Text(gender),
                                ))
                            .toList(),
                      ),
                      vericalSpacer(25),
                      customFormBuilderTextField(
                        'password',
                        Icons.vpn_key,
                        Icons.remove_red_eye_outlined,
                        'Password',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.minLength(context, 6,
                              errorText:
                                  'Good passwords are greater than 6 characters'),
                          FormBuilderValidators.required(context,
                              errorText: 'Password field cannot be empty '),
                        ]),
                      ),
                      // vericalSpacer(25),
                      // customFormBuilderTextField(
                      //   'confirm_password',
                      //   Icons.vpn_key,
                      //   Icons.remove_red_eye_outlined,
                      //   'Confirm Password',
                      //   obscureText: true,
                      //   validator: FormBuilderValidators.compose([
                      //     FormBuilderValidators.notEqual(context,
                      //         _formKey.currentState?.fields['password']?.value,
                      //         errorText: 'Passwords do not match!  '),
                      //   ]),
                      // ),
                      vericalSpacer(30),
                      const StepProgressIndicator(
                        totalSteps: 2,
                        currentStep: 1,
                        selectedGradientColor: LinearGradient(
                            colors: [Colors.purple, Colors.pink],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter),
                        unselectedColor: Colors.grey,
                      ),
                      vericalSpacer(30),
                      CustomButton(
                        formKey: _formKey,
                        onPressed: () {
                          var validate = _formKey.currentState?.validate();
                          if (validate == true) {
                            _formKey.currentState?.save();
                            var username = _formKey
                                .currentState?.fields['username']?.value;
                            var email =
                                _formKey.currentState?.fields['email']?.value;
                            var gender =
                                _formKey.currentState?.fields['gender']?.value;
                            var password = _formKey
                                .currentState?.fields['password']?.value;
                            var phone = '777777';
                            signupBloc?.add(SignUpButtonPressed(
                                email: email,
                                password: password,
                                userName: username,
                                phone: phone,
                                gender: gender));
                          }
                        },
                        child: Text('Next Step',
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(color: Colors.white)),
                      ),
                      vericalSpacer(20),
                      BlocListener<SignupBloc, SignupState>(
                          listener: (context, state) {
                        if (state is SignupSuccessful) {
                          Navigator.pushReplacementNamed(
                              context, SignUpSecondScreen.routeName);
                        }
                      }, child: BlocBuilder<SignupBloc, SignupState>(
                        builder: ((context, state) {
                          if (state is SignupInProgress) {
                            return const SpinKitRotatingPlain(
                              color: Colors.red,
                            );
                          } else if (state is SignupFailed) {
                            return Text(state.message);
                          } else if (state is SignupInProgress) {
                            return Container();
                          }
                          return Container();
                        }),
                      )),
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
    return Stack(children: [
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
            padding: const EdgeInsets.only(bottom: 80, left: 90),
            child: Row(
              children: [
                Text(
                  'Let\'s Get Started',
                  style: Theme.of(context)
                      .textTheme
                      .headline2!
                      .copyWith(color: Colors.black),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  width: 10,
                ),
                const Icon(Icons.insert_emoticon)
              ],
            ),
          ),
        ),
      ),
    ]);
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
    var secondController = Offset(size.width - 55, size.height - 90);
    var secondEnd = Offset(size.width, size.height - 140);
    path.quadraticBezierTo(
      secondController.dx,
      secondController.dy,
      secondEnd.dx,
      secondEnd.dy,
    );
    path.lineTo(size.width, 0);
    path.close;
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return true;
  }

  InputDecoration formDecoration = const InputDecoration(
      floatingLabelStyle: TextStyle(color: Colors.pink),
      fillColor: Colors.pink,
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.pink)),
      prefixIcon: Icon(
        Icons.mail,
        size: 20,
      ),
      labelText: 'Gender');
}
