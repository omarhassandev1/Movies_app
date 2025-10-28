import 'package:flutter/material.dart';
import 'package:movies_app/common/theme/app_colors.dart';

class AppTheme {
  static ThemeData themeData = ThemeData(
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      color: Colors.transparent,
      titleTextStyle: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: AppColors.mainColor,
      )
    ),
    scaffoldBackgroundColor: AppColors.blackColor,
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.mainColor),
    primaryColor: AppColors.mainColor,
    textTheme: _getTextTheme()
  );

  static TextTheme _getTextTheme({Color textColor = AppColors.whiteColor}) {
    return TextTheme(
      // 40px Regular
      displayLarge: TextStyle(
        fontSize: 40.0,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),

      // 36px Bold
      displayMedium: TextStyle(
        fontSize: 36.0,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),

      // 24px Bold
      headlineMedium: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),

      // 20px Bold
      titleLarge: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w700,
        color: textColor,
      ),

      // 20px SemiBold
      titleMedium: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        color: textColor,
      ),

      // 20px Regular
      titleSmall: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),

      // 16px Regular
      bodyLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),

      // 15px Regular
      bodyMedium: TextStyle(
        fontSize: 15.0,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),

      // 14px Regular
      bodySmall: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        color: textColor,
      ),
    );
  }
}
