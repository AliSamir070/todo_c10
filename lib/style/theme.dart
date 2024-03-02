import 'package:flutter/material.dart';
import 'package:todo_c10_maadi/style/app_colors.dart';

class AppTheme{
  static ThemeData lightTheme = ThemeData(
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primaryLightColor
    ),
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.white,fontSize: 20),
      backgroundColor: AppColors.primaryLightColor
    ),
    scaffoldBackgroundColor: AppColors.backgroundColor,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      unselectedItemColor: AppColors.unselectedIconColor,
      selectedItemColor: AppColors.primaryLightColor,
      showSelectedLabels: false,
      showUnselectedLabels: false
    ),
    colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryLightColor,
        primary: AppColors.primaryLightColor
    ),
    useMaterial3: false,
    textTheme: TextTheme(
      labelMedium: TextStyle(
        color: AppColors.textColor,
        fontWeight: FontWeight.w700,
        fontSize: 18
      )
    )
  );
  static ThemeData darkTheme = ThemeData();
}