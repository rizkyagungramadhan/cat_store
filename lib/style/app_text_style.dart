import 'package:cat_store/style/app_color.dart';
import 'package:cat_store/style/app_dimen.dart';
import 'package:flutter/material.dart';

/// Created by rizkyagungramadhan@gmail.com
/// on 15/04/23.

class AppTextStyle extends TextStyle {
  const AppTextStyle._();

  static const _fontFamily = 'Poppins';

  static TextStyle light(
          {Color color = Colors.black38,
          double size = AppDimen.fontMedium,
          bool isUnderlined = false,
          FontWeight? fontWeight = FontWeight.w300}) =>
      TextStyle(
          decoration:
              isUnderlined ? TextDecoration.underline : TextDecoration.none,
          fontSize: size,
          wordSpacing: 0.1,
          color: color,
          fontFamily: _fontFamily,
          fontWeight: fontWeight);

  static TextStyle regular(
          {Color color = Colors.black54,
          double size = AppDimen.fontMedium,
          bool isUnderlined = false}) =>
      TextStyle(
          decoration:
              isUnderlined ? TextDecoration.underline : TextDecoration.none,
          fontSize: size,
          color: color,
          fontFamily: _fontFamily,
          fontWeight: FontWeight.w500);

  static TextStyle bold(
          {Color color = Colors.black87,
          double size = AppDimen.fontMedium,
          bool isUnderlined = false}) =>
      TextStyle(
          decoration:
              isUnderlined ? TextDecoration.underline : TextDecoration.none,
          fontSize: size,
          color: color,
          fontFamily: _fontFamily,
          fontWeight: FontWeight.w700);

  static TextStyle hyperLink({double size = AppDimen.fontMediumLarge}) => light(
        color: AppColor.primary,
        size: size,
      );
}
