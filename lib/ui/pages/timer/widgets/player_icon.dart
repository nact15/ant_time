import 'package:ant_time_flutter/resources/resources.dart';
import 'package:flutter/material.dart';

class PlayerIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback callBack;
  final bool disabled;
  final EdgeInsets padding;

  const PlayerIcon({
    Key? key,
    required this.icon,
    required this.callBack,
    required this.disabled,
    required this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          color: disabled ? AppColors.disabledColor : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(50)),
        ),
        child: InkWell(
          customBorder: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          hoverColor: AppColors.greyButtonHoverColor,
          enableFeedback: !disabled,
          onTap: disabled ? null : callBack,
          splashColor: AppColors.primaryColor,
          child: Container(
            padding: padding,
            child: ShaderMask(
              shaderCallback: (bounds) => const RadialGradient(
                center: Alignment.centerLeft,
                radius: 1.0,
                colors: <Color>[
                  AppColors.primaryColor,
                  AppColors.secondaryColor,
                ],
                tileMode: TileMode.repeated,
              ).createShader(bounds),
              child: Icon(
                icon,
                color: disabled ? AppColors.baseColor : null,
                size: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
