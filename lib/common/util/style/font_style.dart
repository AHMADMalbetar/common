import 'package:flutter/material.dart';

String fontFamily = 'Poppins';

TextTheme textTheme = TextTheme(
  /// Display
  displayLarge: TextStyle(fontSize: 40.0, fontWeight: FontWeight.w400, height: 1.12, color: Colors.white, fontFamily: fontFamily),
  displayMedium: TextStyle(fontSize: 35.0, fontWeight: FontWeight.w400, height: 1.15, color: Colors.white, fontFamily: fontFamily),
  displaySmall: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w400, height: 1.2, color: Colors.white, fontFamily: fontFamily),

  /// Headline
  headlineLarge: TextStyle(fontSize: 25, fontWeight: FontWeight.w400, height: 1.25, color: Colors.white, fontFamily: fontFamily),
  headlineMedium: TextStyle(fontSize: 23.0, fontWeight: FontWeight.w400, height: 1.28, color: Colors.white, fontFamily: fontFamily),
  headlineSmall: TextStyle(fontSize: 21.0, fontWeight: FontWeight.w200, height: 1.3, color: Colors.white, fontFamily: fontFamily),

  /// Title
  titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.w700, height: 1.27, color: Colors.white, fontFamily: fontFamily),
  titleMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700, height: 1.5, color: Colors.white, fontFamily: fontFamily),
  titleSmall: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w500, height: 1.4, color: Colors.white, fontFamily: fontFamily),

  /// Body, bodyMedium is the default text style
  bodyLarge: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, height: 1.4, color: Colors.white, fontFamily: fontFamily),
  bodyMedium: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w400, height: 1.3, color: Colors.white, fontFamily: fontFamily),
  bodySmall: TextStyle(fontSize: 15.0, fontWeight: FontWeight.w400, height: 1.45, color: Colors.white, fontFamily: fontFamily),

  /// Label
  labelLarge: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w300, height: 1.5, color: Colors.white, fontFamily: fontFamily),
  labelMedium: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300, height: 1.4, color: Colors.white, fontFamily: fontFamily),
  labelSmall: TextStyle(fontSize: 10.0, fontWeight: FontWeight.w300, height: 1.3, color: Colors.white, fontFamily: fontFamily),
);
