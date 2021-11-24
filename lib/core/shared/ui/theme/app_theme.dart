import 'package:flutter/material.dart';
import 'package:smart_dispenser/core/shared/ui/theme/app_colors.dart';

abstract class AppTheme {
  static ThemeData get theme => ThemeData.light().copyWith(
        primaryColor: AppColors.primary,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: AppColors.secondary,
        ),
        scaffoldBackgroundColor: AppColors.white,
        primaryColorLight: AppColors.primaryLight,
      );
}
