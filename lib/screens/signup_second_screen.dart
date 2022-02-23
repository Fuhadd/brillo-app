import 'package:brilloapp/config/Helpers/constants.dart';
import 'package:brilloapp/config/blocs/bloc/image_storage_bloc/image_bloc.dart';
import 'package:brilloapp/screens/home_screen.dart';
import 'package:brilloapp/screens/verification_screen.dart';
import 'package:brilloapp/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class SignUpSecondScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormBuilderState>();
  static const routeName = '/signupSecond';

  SignUpSecondScreen() : super();
  ImageBloc? imageBloc;

  @override
  Widget build(BuildContext context) {
    imageBloc = BlocProvider.of<ImageBloc>(context);
    return Scaffold(
        extendBodyBehindAppBar: true,
        //here too
        body: Builder(builder: (context) {
          return Column(
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
                          Stack(
                            children: [
                              Center(
                                child: Container(
                                  alignment: Alignment.center,
                                  height: 204,
                                  width: 148,
                                  color: Colors.pink,
                                ),
                              ),
                              Center(
                                child: BlocListener<ImageBloc, ImageState>(
                                  listener: (context, state) {
                                    if (state is ImagePickerSuccessful) {
                                      Navigator.of(context).pop();
                                      return;
                                    }
                                  },
                                  child: BlocBuilder<ImageBloc, ImageState>(
                                    builder: (context, state) {
                                      if (state is ImagePickerSuccessful) {
                                        return Container(
                                          alignment: Alignment.center,
                                          height: 200,
                                          width: 140,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: FileImage(state.image),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      } else if (state is ImagePickerFailed) {
                                        Navigator.of(context).pop();
                                        return Container(
                                          alignment: Alignment.center,
                                          height: 200,
                                          width: 140,
                                          color: Colors.white,
                                          child: Text(state.message),
                                        );
                                      } else if (state
                                          is ImagePickerInProgress) {
                                        Future.delayed(Duration.zero, () {
                                          showdialog(context);
                                        });
                                        ;
                                      }
                                      return Container(
                                        alignment: Alignment.center,
                                        height: 200,
                                        width: 140,
                                        color: Colors.white,
                                      );
                                    },
                                  ),
                                ),
                              ),
                              // Positioned(
                              //     right: 138,
                              //     bottom: 0,
                              //     child: GestureDetector(
                              //       onTap: () {
                              //         imageBloc?.add(ImagePickerEvent());
                              //       },
                              //       child: Container(
                              //           color: Colors.pink,
                              //           child: Padding(
                              //             padding: const EdgeInsets.symmetric(
                              //                 vertical: 3, horizontal: 15),
                              //             child: Row(
                              //               children: const [
                              //                 Text(
                              //                   'Upload Image',
                              //                   style: TextStyle(
                              //                       color: Colors.white),
                              //                 ),
                              //                 Icon(
                              //                   Icons.add,
                              //                   color: Colors.white,
                              //                   size: 25,
                              //                 ),
                              //               ],
                              //             ),
                              //           )),
                              //     ))
                            ],
                          ),
                          vericalSpacer(10),
                          CustomWhiteButton(
                            onPressed: () {
                              imageBloc?.add(ImagePickerEvent());
                            },
                            child: Row(
                              children: const [
                                Text(
                                  'Upload Image',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                  size: 25,
                                ),
                              ],
                            ),
                          ),
                          vericalSpacer(10),
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
                              Text(
                                'Interests',
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 18),
                              ),
                            ],
                          ),
                          vericalSpacer(9),
                          FormBuilderFilterChip(
                            //selectedColor: Colors.pink,
                            runSpacing: 10,
                            spacing: 10,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            backgroundColor: Colors.pink,
                            checkmarkColor: Colors.pink,
                            elevation: 10,
                            name: 'interests',
                            options: options,
                            decoration: const InputDecoration(
                              hoverColor: Colors.white,
                              floatingLabelStyle: TextStyle(color: Colors.pink),
                              fillColor: Colors.pink,
                              enabledBorder: UnderlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.pink)),
                            ),
                          ),
                          vericalSpacer(30),
                          const StepProgressIndicator(
                            totalSteps: 2,
                            currentStep: 2,
                            selectedGradientColor: LinearGradient(
                                colors: [Colors.purple, Colors.pink],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter),
                            unselectedColor: Colors.grey,
                          ),
                          vericalSpacer(20),
                          CustomButton(
                            child: const Text(
                              'Next Step',
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
                                var interests = _formKey
                                    .currentState?.fields['interests']?.value;
                                imageBloc?.add(
                                    SaveInterestsEvent(interests: interests));
                              }
                            },
                          ),
                          BlocListener<ImageBloc, ImageState>(
                            listener: (context, state) {
                              if (state is SaveInterestSuccessful) {
                                Navigator.pushReplacementNamed(
                                    context, VerifyEmailScreen.routeName);
                              }
                            },
                            child: BlocBuilder<ImageBloc, ImageState>(
                                builder: (context, state) {
                              if (state is SaveInterestFailed) {
                                return Text(state.message);
                              } else if (state is SaveInterestSuccessful) {
                                return Container();
                              } else if (state is SaveInterestInProgress) {
                                showdialog(context);
                              }
                              return Container();
                            }),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }));
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
                    'We Just Need a Few More Details!!',
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
