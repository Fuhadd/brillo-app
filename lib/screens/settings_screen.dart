import 'package:brilloapp/config/Helpers/constants.dart';
import 'package:brilloapp/screens/forgot_password_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Column(
        children: [
          vericalSpacer(20),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, ForgotPassword.routeName);
            },
            child: Card(
              margin: EdgeInsets.all(20),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(Icons.mode_edit),
                    horizontalSpacer(20),
                    Text('Change/Reset Password')
                  ],
                ),
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: [
                    Icon(Icons.logout),
                    horizontalSpacer(10),
                    Text('Logout')
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
