import 'package:ant_time_flutter/resources/resources.dart';
import 'package:flutter/material.dart';

class BaseTooltip extends StatelessWidget {
  final String message;
  final Widget child;

  const BaseTooltip({
    Key? key,
    required this.message,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      decoration: const BoxDecoration(
        color: AppColors.disabledColor,
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
      textStyle: AppTextStyles.tooltipStyle,
      message: message,
      child: child,
    );
  }
}
