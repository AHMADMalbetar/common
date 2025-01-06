import 'package:common/common/extensions/font_extensions.dart';
import 'package:flutter/material.dart';

import 'app_image.dart';


enum ButtonContentType { text, icon, image }

enum ButtonStyle { withoutAnimation, animated, icon, text }

enum ImageType { assets, network }

class AppButton extends StatelessWidget {
  Color? outlineColor;
  Color? filledColor;
  Color? contentColor;
  String? title;
  TextStyle? textStyle;
  String? image;
  double? radius;
  double? height;
  double? imageHeight;
  double? imageWidth;
  double? iconSize;
  double? width;
  EdgeInsetsGeometry? contentPadding;
  List<BoxShadow>? shadow;
  IconData? icon;
  Function()? onTap;
  Function()? onDoubleTap;

  ButtonContentType? buttonType;
  ButtonStyle buttonStyle;
  ImageType? imageType;

  AppButton.animated({
    super.key,
    this.outlineColor,
    this.filledColor,
    this.contentColor,
    this.title,
    this.textStyle,
    this.radius = 12,
    this.height = 40,
    this.width = double.infinity,
    this.imageHeight = 25,
    this.imageWidth = 25,
    this.contentPadding,
    this.shadow,
    this.iconSize = 25,
    this.icon,
    this.image,
    this.imageType,
    this.onTap,
    this.onDoubleTap,
    required this.buttonType,
  }) : buttonStyle = ButtonStyle.animated;

  AppButton.withoutAnimation({
    super.key,
    this.outlineColor,
    this.contentColor,
    this.title,
    this.textStyle,
    this.radius = 12,
    this.height = 40,
    this.width = double.infinity,
    this.imageHeight = 25,
    this.imageWidth = 25,
    this.contentPadding,
    this.shadow,
    this.iconSize = 25,
    this.icon,
    this.image,
    this.filledColor,
    this.imageType,
    this.onTap,
    this.onDoubleTap,
    required this.buttonType,
  }) : buttonStyle = ButtonStyle.withoutAnimation;

  AppButton.icon({
    super.key,
    required this.onTap,
    this.icon,
    this.iconSize,
    this.contentColor,
  }) : buttonStyle = ButtonStyle.icon;

  AppButton.text({
    super.key,
    required this.onTap,
    this.title,
    this.textStyle,
  }) : buttonStyle = ButtonStyle.text;

  @override
  Widget build(BuildContext context) {
    return switch (buttonStyle) {
      ButtonStyle.withoutAnimation => GestureDetector(
          onDoubleTap: onDoubleTap,
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius!),
              border: Border.all(color: outlineColor ?? context.primaryColor),
              boxShadow: shadow,
              color: onTap == null && onDoubleTap == null ? context.primaryColor.withOpacity(.2) : filledColor ?? context.primaryColor,
            ),
            padding: contentPadding,
            width: width,
            height: height,
            child: switch (buttonType!) {
              ButtonContentType.text => Center(
                  child: Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: textStyle ?? context.theme.textTheme.headlineSmall,
                  ),
                ),
              ButtonContentType.icon => Icon(
                  icon,
                  color: contentColor ?? context.onPrimaryColor,
                  size: iconSize,
                ),
              ButtonContentType.image => switch (imageType!) {
                  ImageType.assets => AppImage.asset(
                      image!,
                      fit: BoxFit.cover,
                    ),
                  ImageType.network => AppImage.network(
                      image!,
                      fit: BoxFit.cover,
                    ),
                },
            },
          ),
        ),
      ButtonStyle.animated => InkWell(
          borderRadius: BorderRadius.circular(radius!),
          onDoubleTap: onDoubleTap,
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius!),
              border: Border.all(color: outlineColor ?? context.primaryColor),
              boxShadow: shadow,
              color: onTap == null && onDoubleTap == null ? context.primaryColor.withOpacity(.2) : filledColor ?? context.primaryColor,
            ),
            padding: contentPadding,
            width: width,
            height: height,
            child: switch (buttonType!) {
              ButtonContentType.text => Center(
                  child: Text(
                    title!,
                    textAlign: TextAlign.center,
                    style: textStyle ?? context.theme.textTheme.headlineSmall,
                  ),
                ),
              ButtonContentType.icon => Icon(
                  icon,
                  color: contentColor ?? context.onPrimaryColor,
                  size: iconSize,
                ),
              ButtonContentType.image => switch (imageType!) {
                  ImageType.assets => AppImage.asset(
                      image!,
                      fit: BoxFit.cover,
                      width: imageWidth,
                      height: imageHeight,
                    ),
                  ImageType.network => AppImage.network(
                      image!,
                      fit: BoxFit.cover,
                      width: imageWidth,
                      height: imageHeight,
                    ),
                },
            },
          ),
        ),
      ButtonStyle.icon => IconButton(
          onPressed: onTap,
          icon: Icon(
            icon,
            color: onTap == null ? context.primaryColor.withOpacity(.2) : contentColor ?? context.onPrimaryColor,
            size: iconSize,
          ),
        ),
      ButtonStyle.text => TextButton(
          onPressed: onTap,
          child: Text(
            title!,
            style: textStyle!,
          ),
        ),
    };
  }
}
