import 'package:ant_time_flutter/resources/app_colors.dart';
import 'package:ant_time_flutter/resources/app_text_styles.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData mainTheme = ThemeData(
    primaryColor: AppColors.primaryColor,
    hoverColor: AppColors.hoverColor,
    primaryIconTheme: const IconThemeData(
      color: AppColors.primaryColor,
    ),
    brightness: Brightness.light,
    iconTheme: const IconThemeData(
      color: AppColors.primaryColor,
    ),
    textTheme: TextTheme(
      headline4: AppTextStyles.titleIssueStyle,
      headline5: AppTextStyles.descriptionIssueStyle,
    ),
    disabledColor: AppColors.borderColor,
    cardColor: Colors.white,
    backgroundColor: AppColors.backgroundColor,
    focusColor: AppColors.primaryColor,
    scrollbarTheme: ScrollbarThemeData(
      trackVisibility: MaterialStateProperty.all<bool>(false),
      isAlwaysShown: true,
      trackColor: MaterialStateProperty.all<Color>(AppColors.greyColor),
      trackBorderColor: MaterialStateProperty.all<Color>(AppColors.greyColor),
      thumbColor: MaterialStateProperty.all<Color>(AppColors.baseColor),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryColor: AppColors.primaryDarkColor,
    hoverColor: AppColors.hoverDarkColor,
    primaryIconTheme: const IconThemeData(
      color: AppColors.primaryDarkColor,
    ),
    iconTheme: const IconThemeData(
      color: AppColors.primaryDarkColor,
    ),
    focusColor: AppColors.primaryDarkColor,
    brightness: Brightness.dark,
    textTheme: TextTheme(
      headline4: AppTextStyles.titleIssueStyle.copyWith(
        color: Colors.white,
      ),
      headline5: AppTextStyles.descriptionIssueStyle.copyWith(
        color: Colors.white,
      ),
    ),
    disabledColor: AppColors.disabledDarkColor,
    cardColor: AppColors.thirdDarkColor,
    backgroundColor: AppColors.backgroundDarkColor,
    scrollbarTheme: ScrollbarThemeData(
      trackVisibility: MaterialStateProperty.all<bool>(false),
      isAlwaysShown: true,
      trackColor: MaterialStateProperty.all<Color>(AppColors.greyColor),
      trackBorderColor: MaterialStateProperty.all<Color>(AppColors.greyColor),
      thumbColor: MaterialStateProperty.all<Color>(AppColors.primaryDarkColor),
    ),
  );
}
