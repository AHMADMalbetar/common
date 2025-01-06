import 'package:flutter/material.dart';

extension NavigationExtensions on BuildContext{

  void pop<T extends Object?>([T? result]) => Navigator.of(this).pop<T>(result);
  void popUntil<T extends Object?>(context, RoutePredicate route) => Navigator.popUntil(this, route);

  Future<T?> push<T extends Object?>(context, screen) => Navigator.push(this, MaterialPageRoute(builder: (context) => screen));
  Future<T?> pushAndReplace<T extends Object?>(context, screen) => Navigator.pushReplacement(this, MaterialPageRoute(builder: (context) => screen));
  Future<T?> pushAndRemove<T extends Object?>(context, screen) => Navigator.pushAndRemoveUntil(this, MaterialPageRoute(builder: (context) => screen), (route) => false);

}