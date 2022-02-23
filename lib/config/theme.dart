import 'package:flutter/material.dart';

ThemeData theme() {
  return ThemeData(
      primarySwatch: Colors.pink,
      secondaryHeaderColor: Colors.deepPurple,
      accentColor: Colors.pink,
      textTheme: const TextTheme(
        headline1: TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.bold,
          fontSize: 36,
        ),
        headline2: TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.bold,
          fontSize: 24,
        ),
        headline3: TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
        headline4: TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        headline5: TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.bold,
          fontSize: 14,
        ),
        headline6: TextStyle(
          color: Color(0xFF2B2E4A),
          fontWeight: FontWeight.normal,
          fontSize: 10,
        ),
      ));
}
