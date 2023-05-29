import 'package:ant_time_flutter/resources/resources.dart';
import 'package:flutter/material.dart';

class AppDecoration {
  static InputDecoration textFieldDecoration = InputDecoration(
    hintStyle: AppTextStyles.hintStyle,
    labelStyle: AppTextStyles.hintStyle,
    border: textFieldBorder,
    focusedBorder: textFieldFocusedBorder,
    enabledBorder: textFieldBorder,
    errorBorder: textFieldErrorBorder,
    disabledBorder: textFieldDisabledBorder,
    constraints: const BoxConstraints(
      maxHeight: 48,
    ),
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 5,
    ),
    errorStyle: AppTextStyles.errorStyle,
    prefixIconColor: AppColors.primaryColor,
    iconColor: AppColors.primaryColor,
    filled: true,
    fillColor: Colors.white,
    focusedErrorBorder: textFieldErrorBorder,
    prefixIconConstraints: const BoxConstraints(
      minHeight: 16,
      minWidth: 16,
    ),
  );

  static OutlineInputBorder textFieldBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: AppColors.borderColor),
  );

  static OutlineInputBorder textFieldFocusedBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  static OutlineInputBorder textFieldDisabledBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
  );

  static OutlineInputBorder textFieldErrorBorder = const OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(10)),
    borderSide: BorderSide(color: AppColors.errorColor),
  );

  AppDecoration._();
}
