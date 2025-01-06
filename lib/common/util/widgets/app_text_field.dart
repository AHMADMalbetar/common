import 'package:common/common/extensions/font_extensions.dart';
import 'package:flutter/material.dart';

class AppCustomTextField extends StatelessWidget {
  AppCustomTextField({
    super.key,
    required this.controller,
    required this.hint,
    this.height,
    this.width,
    this.onTap,
    this.radios,
    this.textAlign,
    this.sufIcon,
    this.contentPadding,
    this.fontSized,
    this.keyboardType,
    this.readOnly,
    this.obSecure,
    this.onChanged,
    this.preIcon,
    this.validator,
    this.mainColor,
    this.hintStyle,
    this.filledColor,
    this.mnLine,
    this.mxLine,
    this.borderWidth,
    this.focusNode,
  });

  final TextEditingController controller;
  final Widget? preIcon;
  final String hint;
  final ValueChanged<String>? onChanged;
  final Widget? sufIcon;
  final bool? obSecure;
  final bool? readOnly;
  final double? height;
  final double? width;
  final double? borderWidth;
  final double? radios;
  final double? fontSized;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final EdgeInsetsGeometry? contentPadding;
  final Color? mainColor;
  final TextStyle? hintStyle;
  Function()? onTap;
  Color? filledColor;
  int? mnLine;
  int? mxLine;
  FocusNode? focusNode;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height, width: width,
      child: TextFormField(
        focusNode: focusNode,
        style: context.textTheme.titleSmall!.copyWith(color: context.onSecondary),
        textAlignVertical: TextAlignVertical.center,
        textAlign: textAlign ?? TextAlign.start,
        obscureText: obSecure ?? false,
        controller: controller,
        onChanged: onChanged,
        onTap: onTap,
        minLines: mnLine,
        maxLines: mxLine,
        readOnly: readOnly ?? false,
        keyboardType: keyboardType ?? TextInputType.emailAddress,
        validator: validator,
        decoration: InputDecoration(
          filled: true,
          fillColor: filledColor ?? context.onSecondaryContainer,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(radios ?? 60),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: mainColor ?? context.primaryColor, // Replace with MyColors.buttonColor
              width: 0.5,
            ),
            borderRadius: BorderRadius.circular(radios ?? 60.0),
          ),
          contentPadding: contentPadding,
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: mainColor ?? context.primaryColor, // Replace with MyColors.buttonColor
              width: borderWidth ?? 0.5,
            ),
            borderRadius: BorderRadius.circular(radios ?? 60.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: mainColor ?? context.onSecondaryContainer, width: .2),
            // Replace with MyColors.noColor
            borderRadius: BorderRadius.circular(radios ?? 60.0),
          ),
          suffixIcon: sufIcon,
          prefixIcon: preIcon,
          hintText: hint,
          hintStyle: hintStyle ?? context.textTheme.titleSmall!.copyWith(
            color: mainColor,
          ),
        ),
      ),
    );
  }
}
