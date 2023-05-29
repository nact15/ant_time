import 'package:ant_time_flutter/resources/app_colors.dart';
import 'package:flutter/material.dart';

extension ThemeDataExtension on ThemeData {
  bool get isDark => brightness == Brightness.dark;

  Color get reversedColor => isDark ? Colors.white : Colors.black;

  Color get borderColor => isDark ? AppColors.borderDarkColor : AppColors.greyColor;

  Color get subColor => isDark ? backgroundColor : Colors.white; // AppColors.subColor;

  Color get subReversedColor => isDark ? Colors.white : AppColors.subColor;

  Color get secondaryDarkColor => isDark ? AppColors.secondaryDarkColor : AppColors.deepGreyColor;

  Color get switcherBackgroundColor => isDark ? AppColors.hoverDarkColor : AppColors.hoverColor;

  Color get switcherCheckedColor =>
      isDark ? AppColors.greyDarkColor : AppColors.greyButtonHoverColor;

  Color get switcherUnBackgroundColor =>
      isDark ? AppColors.secondaryBackgroundDarkColor : AppColors.greyColor;

  Color get arrowDisabledColor => isDark ? AppColors.greyDarkColor : AppColors.iconColor;
}
