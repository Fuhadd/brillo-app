import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BuddiesScreen extends StatelessWidget {
  const BuddiesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buddies'),
      ),
      body: Center(child: Text('Buddies Screen')),
    );
  }
}
