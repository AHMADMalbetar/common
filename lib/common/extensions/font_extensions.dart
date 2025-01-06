import 'package:flutter/material.dart';

extension ThemeExtensions on BuildContext{
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => Theme.of(this).textTheme;

  Color get onPrimaryColor => colorScheme.onPrimary;

  Color get shadow => colorScheme.shadow;

  Color get primaryColor => colorScheme.primary;

  Color get outLine => colorScheme.outline;

  Color get onBackGoundColor => colorScheme.onBackground;

  Color get backGoundColor => colorScheme.background;

  Color get error => colorScheme.error;

  Color get inverse => colorScheme.inversePrimary;

  Color get surface => colorScheme.surface;

  Color get onSurface => colorScheme.onSurface;

  Color get secondary => colorScheme.secondary;

  Color get onSecondary => colorScheme.onSecondary;

  Color get onPrimaryContainer => colorScheme.onPrimaryContainer;

  Color get onSecondaryContainer => colorScheme.onSecondaryContainer;

  DefaultTextStyle get defaultTextStyle => DefaultTextStyle.of(this);

}