import 'package:cat_store/style/app_color.dart';
import 'package:flutter/material.dart';

class AppGradient {
  const AppGradient._();

  static const verticalPrimaryToPrimaryLight = LinearGradient(
      colors: [AppColor.primary, AppColor.primaryLight],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.35, 1.0],
      tileMode: TileMode.decal);

  static const verticalWhiteToGray = LinearGradient(
      colors: [Colors.white, AppColor.grayDark],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.35, 1.0],
      tileMode: TileMode.decal);

  static const verticalGrayDarkToLight = LinearGradient(
      colors: [AppColor.grayLight, AppColor.grayDark],
      begin: Alignment.bottomCenter,
      end: Alignment.topCenter,
      stops: [0.8, 1.0],
      tileMode: TileMode.decal);
}
