import 'package:cat_store/style/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  const AppTheme._();

  static final ThemeData theme = ThemeData(
    appBarTheme: const AppBarTheme().copyWith(
      backgroundColor: AppColor.primary,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarColor: AppColor.primary,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    primaryColor: AppColor.primary,
    canvasColor: Colors.transparent,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColor.accent,
      primary: AppColor.primary,
      background: AppColor.grayLight,
    ),
    scaffoldBackgroundColor: Colors.white,
  );
}
