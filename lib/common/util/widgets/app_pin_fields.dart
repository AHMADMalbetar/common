import 'package:common/common/extensions/font_extensions.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class AppPinFields extends StatelessWidget {
  const AppPinFields({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      length: 6,
      obscureText: false,
      animationType: AnimationType.fade,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(10),
        fieldHeight: 40,
        fieldWidth: 40,
        activeFillColor: Colors.white,
        inactiveColor: context.secondary.withOpacity(.3),
        activeColor: context.secondary.withOpacity(.3),
        inactiveFillColor: Colors.transparent,
        selectedFillColor: Colors.transparent,
        selectedColor: context.secondary.withOpacity(.3),
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.transparent,
      mainAxisAlignment: MainAxisAlignment.center,
      separatorBuilder: (context, index) => const SizedBox(width: 10,),
      cursorColor: context.secondary,
      enableActiveFill: true,
      controller: controller,
      appContext: context,
    );
  }
}
