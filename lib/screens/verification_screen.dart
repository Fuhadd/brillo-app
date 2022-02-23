import 'dart:async';

import 'package:brilloapp/config/Helpers/constants.dart';
import 'package:brilloapp/screens/bottom_navigation.dart';
import 'package:brilloapp/screens/home_screen.dart';
import 'package:brilloapp/screens/login_screen.dart';
import 'package:brilloapp/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyEmailScreen extends StatefulWidget {
  const VerifyEmailScreen({Key? key}) : super(key: key);
  static const routeName = '/verifyEmail';

  @override
  _VerifyEmailScreenState createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends State<VerifyEmailScreen> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initState() {
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

    Future sendVerificationEmail() async {
      try {
        final user = FirebaseAuth.instance.currentUser!;
        await user.sendEmailVerification();
        setState(() => canResendEmail = false);
        await Future.delayed(Duration(seconds: 10));
        setState(() => canResendEmail = true);
      } catch (e) {}
    }

    Future checkEmailVerified() async {
      await FirebaseAuth.instance.currentUser!.reload();
      setState(() {
        isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
        if (isEmailVerified) timer?.cancel();
      });
    }

    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(Duration(seconds: 3), (_) => checkEmailVerified);
    }
  }

  @override
  void dispose() {
    timer?.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? BottomNavigation()
      : Scaffold(
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
                          const Text('Incorrect Email Provided ?'),
                          horizontalSpacer(5),
                          TextButton(
                            onPressed: () {
                              // sendVerificationEmail();
                            },
                            child: const Text(
                              'Change Email',
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
                const Padding(
                  padding: EdgeInsets.only(
                    left: 40,
                    right: 40,
                    bottom: 40,
                    top: 30,
                  ),
                  child: Text(
                    'A verification link has been sent to your mail, Click on the link to continue with your registration. Don\'t forget to check Spam Folders',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  child: Column(
                    children: [
                      const Text(
                          ' If you are not automatically directed to the homepage after verification, click button below'),
                      vericalSpacer(10),
                      CustomNewButton(
                          onPressed: () {
                            setState(() {});
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.send),
                              horizontalSpacer(10),
                              Text('Reload Page')
                            ],
                          )),
                    ],
                  ),
                ),
                vericalSpacer(20),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 40,
                  ),
                  child: CustomWhiteButton(
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
                      )),
                )
              ],
            ),
          ),
        );
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
            decoration: BoxDecoration(color: Colors.purple),
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
                    'Verify your Email',
                    style: Theme.of(context)
                        .textTheme
                        .headline2!
                        .copyWith(color: Colors.black),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Icon(Icons.insert_emoticon)
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
