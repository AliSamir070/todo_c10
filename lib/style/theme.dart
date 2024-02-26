import 'package:flutter/material.dart';
import 'package:todo_c10_maadi/style/app_colors.dart';

class AppTheme{
  static ThemeData lightTheme = ThemeData(
    appBarTheme: AppBarTheme(
      backgroundColor: AppColors.primaryLightColor
    ),
    scaffoldBackgroundColor: AppColors.backgroundColor,
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryLightColor,
        primary: AppColors.primaryLightColor
    )
  );
  static ThemeData darkTheme = ThemeData();
}