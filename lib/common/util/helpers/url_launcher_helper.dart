import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';

class URLLauncherHelper {
  static Future<void> launchURL({
    required String url,
    required BuildContext context,
  }) async {
    final Uri uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Fluttertoast.showToast(
        msg: 'Error while launching:\n$url',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14,
      );
    }
  }

  static Future<void> makeCall(String phone) async {
    final Uri call = Uri(scheme: 'tel', path: phone);

    if (await canLaunchUrl(call)) {
      await launchUrl(call);
    } else {
      Fluttertoast.showToast(
        msg: 'Error while making call:\n$phone',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14,
      );
    }
  }

  static Future<void> launchEmail(String emailAddress) async {
    final Uri email = Uri(scheme: 'mailto', path: emailAddress);

    if (await canLaunchUrl(email)) {
      await launchUrl(email);
    } else {
      Fluttertoast.showToast(
        msg: 'Error while sending email:\n$emailAddress',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14,
      );
    }
  }

  static Future<void> launchSMS(String phoneNumber, {String? message}) async {
    final Uri sms = Uri(
      scheme: 'sms',
      path: phoneNumber,
      queryParameters: message != null ? {'body': message} : null,
    );

    if (await canLaunchUrl(sms)) {
      await launchUrl(sms);
    } else {
      Fluttertoast.showToast(
        msg: 'Error while sending SMS:\n$phoneNumber',
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 14,
      );
    }
  }
}
