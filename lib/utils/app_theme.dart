
import 'package:evently_app_new/utils/app_styles.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
      primaryColor: AppColors.primaryLight,
      scaffoldBackgroundColor: AppColors.whiteBgColor,
      textTheme: TextTheme(
          headlineLarge: AppStyles.bold20Black
      )
  );

  static final ThemeData darkTheme = ThemeData(
      primaryColor: AppColors.primaryDark,
      scaffoldBackgroundColor: AppColors.primaryDark,
      textTheme: TextTheme(
          headlineLarge: AppStyles.bold20White
      )
  );
}
