import 'package:common/common/extensions/font_extensions.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastComponent{
  static showToast(BuildContext context, {
    required String msg,
    Color? backgroundColor,
    Color? textColor,
  }){
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: backgroundColor ?? context.primaryColor,
        textColor: textColor ?? context.onPrimaryColor,
        fontSize: 14,
    );
  }
}