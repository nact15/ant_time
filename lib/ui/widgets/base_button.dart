import 'package:ant_time_flutter/resources/resources.dart';
import 'package:flutter/material.dart';

import 'base_progress_indicator.dart';

class BaseButton extends StatelessWidget {
  final Function() onTap;
  final Widget child;
  final bool disabled;
  final double? width;
  final double? height;
  final Color? color;
  final bool loading;

  const BaseButton({
    Key? key,
    required this.onTap,
    required this.child,
    this.disabled = false,
    this.width,
    this.height,
    this.color,
    this.loading = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 150,
      height: height ?? 48,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        gradient: color != null || disabled
            ? null
            : const LinearGradient(
                colors: [
                  AppColors.primaryColor,
                  AppColors.secondaryColor,
                ],
              ),
      ),
      child: OutlinedButton(
        onPressed: disabled ? null : onTap,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
            if (states.contains(MaterialState.disabled)) {
              return AppColors.iconColor;
            }

            return Colors.transparent;
          }),
          enableFeedback: !disabled,
          overlayColor: MaterialStateProperty.resolveWith<Color>((_) {
            return AppColors.buttonHoverColor.withOpacity(0.5);
          }),
          elevation: MaterialStateProperty.resolveWith<double>((_) => 0),
          shape: MaterialStateProperty.resolveWith<OutlinedBorder>((states) {
            return const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            );
          }),
        ),
        child: loading ? const BaseProgressIndicator() : child,
      ),
    );
  }
}
