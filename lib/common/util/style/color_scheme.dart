import 'package:flutter/material.dart';

class ThemesColorScheme {
  static ColorScheme lightColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xff1F41BB),
    onPrimary: Colors.white,
    secondary: Color(0xffF1F4FF),
    onSecondary: Color(0xff626262),
    error: Color(0xffFE0F00),
    onError: Colors.white,
    surface: Color(0xffFFE1E1),
    onSurface: Colors.white,
    background: Color(0xff4285F4),
    onBackground: Color(0xffFFE1E1),
    onPrimaryContainer: Colors.black,
    shadow: Color(0xff6F7BA7),
    onSecondaryContainer: Color(0xff606260),
    inversePrimary: Color(0xff34C759),
    outline: Color(0xff0A0A0A),
  );

  static ColorScheme devLightColorScheme = const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xffFF6400),
    onPrimary: Colors.white,
    secondary: Color(0xffF1F4FF),
    onSecondary: Color(0xff626262),
    error: Color(0xffFE0F00),
    onError: Colors.white,
    surface: Color(0xffFFE1E1),
    onSurface: Colors.white,
    background: Color(0xff4285F4),
    onBackground: Color(0xffFFE1E1),
    onPrimaryContainer: Colors.black,
    shadow: Color(0xff6F7BA7),
    onSecondaryContainer: Color(0xff606260),
    inversePrimary: Color(0xff34C759),
    outline: Color(0xff0A0A0A),
  );
}
