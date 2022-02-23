import 'package:brilloapp/screens/signup_screen.dart';
import 'package:brilloapp/screens/signup_second_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: (() async {
              FirebaseAuth.instance.signOut();
            }),
            child: Text('Test')),
      ),
    );
  }
}
