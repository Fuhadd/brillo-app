// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required GlobalKey<FormBuilderState> formKey,
    // required this.loginBloc,
    required this.onPressed,
    required this.child,
  })  : _formKey = formKey,
        super(key: key);

  final GlobalKey<FormBuilderState> _formKey;

  final onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
            colors: [Colors.pink, Colors.purple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            overlayColor: MaterialStateProperty.all(Colors.pink),
            elevation: MaterialStateProperty.all(10),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          onPressed: onPressed,
          child: child),
    );
  }
}

class CustomNewButton extends StatelessWidget {
  const CustomNewButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  final onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
            colors: [Colors.pink, Colors.purple],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter),
      ),
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            overlayColor: MaterialStateProperty.all(Colors.pink),
            elevation: MaterialStateProperty.all(10),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          onPressed: onPressed,
          child: child),
    );
  }
}

class CustomWhiteButton extends StatelessWidget {
  const CustomWhiteButton({
    Key? key,
    required this.onPressed,
    required this.child,
  }) : super(key: key);

  final onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), color: Colors.purple
          // gradient: const LinearGradient(
          //     colors: [Colors.white, Colors.white],
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter),
          ),
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.transparent),
            overlayColor: MaterialStateProperty.all(Colors.pink),
            elevation: MaterialStateProperty.all(10),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          onPressed: onPressed,
          child: child),
    );
  }
}
