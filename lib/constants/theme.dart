import 'package:flutter/material.dart';

class AppTheme {
  customAppTheme() {
    return ThemeData(
        textTheme: const TextTheme(
            bodyLarge: TextStyle(
                fontSize: 30, color: Colors.black, fontWeight: FontWeight.w800),
            bodyMedium: TextStyle(
                fontSize: 25, color: Colors.black, fontWeight: FontWeight.w400),
            bodySmall: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.w400)));
  }
}
