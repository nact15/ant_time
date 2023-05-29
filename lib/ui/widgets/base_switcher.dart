import 'package:ant_time_flutter/resources/app_colors.dart';
import 'package:ant_time_flutter/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:simple_animations/simple_animations.dart';

enum SwitcherProps {
  padding,
  color,
  backgroundColor,
}

class CustomSwitchButton extends StatefulWidget {
  final bool checked;

  final Color checkedColor;
  final Color unCheckedColor;

  final Duration animationDuration;

  final Color backgroundColor;
  final Color unBackgroundColor;

  final double buttonWidth;

  final double buttonHeight;
  final double indicatorWidth;
  final double backgroundBorderRadius;

  // отступ от круга
  final double paddingOut;

  const CustomSwitchButton({
    required this.backgroundColor,
    required this.unBackgroundColor,
    required this.checked,
    required this.checkedColor,
    required this.unCheckedColor,
    required this.animationDuration,
    required this.buttonWidth,
    required this.buttonHeight,
    required this.indicatorWidth,
    this.backgroundBorderRadius = 30,
    this.paddingOut = 2,
  });

  @override
  State<CustomSwitchButton> createState() => _CustomSwitchButtonState();
}

class _CustomSwitchButtonState extends State<CustomSwitchButton> with AnimationMixin {
  late Tween padding;
  late TimelineTween<SwitcherProps> _tween;

  late ColorTween _color;
  late ColorTween _backgroundColor;

  @override
  void initState() {
    _createTweens();
    _tween = _createTween();
    super.initState();
  }

  @override
  void didUpdateWidget(CustomSwitchButton oldWidget) {
    if (widget.checkedColor != oldWidget.checkedColor) {
      _createTweens();
      _tween = _createTween();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    CustomAnimationControl control =
        widget.checked ? CustomAnimationControl.play : CustomAnimationControl.playReverse;

    return CustomAnimation<TimelineValue<SwitcherProps>>(
      control: control,
      curve: Curves.easeInOut,
      tween: _tween,
      duration: _tween.duration,
      builder: (context, child, value) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: Container(
            width: widget.buttonWidth,
            height: widget.buttonHeight,
            decoration: _outerBoxDecoration(
              value.get(SwitcherProps.backgroundColor),
            ),
            child: Transform.translate(
              offset: Offset(value.get(SwitcherProps.padding), 0),
              child: Stack(
                children: [
                  Container(
                    decoration: _innerBoxDecoration((value.get(SwitcherProps.color))),
                    width: widget.indicatorWidth,
                    height: widget.indicatorWidth,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _createTweens() {
    padding = Tween(
      begin: widget.paddingOut,
      end: widget.indicatorWidth - widget.paddingOut,
    );
    _color = ColorTween(
      begin: widget.unCheckedColor,
      end: widget.checkedColor,
    );
    _backgroundColor = ColorTween(
      begin: widget.unBackgroundColor,
      end: widget.backgroundColor,
    );
  }

  TimelineTween<SwitcherProps> _createTween() => TimelineTween<SwitcherProps>()
    ..addScene(begin: Duration.zero, duration: widget.animationDuration)
        .animate(SwitcherProps.padding, tween: padding)
        .animate(SwitcherProps.color, tween: _color)
        .animate(SwitcherProps.backgroundColor, tween: _backgroundColor)
    ..addScene(begin: Duration.zero, duration: widget.animationDuration)
        .animate(SwitcherProps.padding, tween: padding)
        .animate(SwitcherProps.color, tween: _color)
        .animate(SwitcherProps.backgroundColor, tween: _backgroundColor);

  BoxDecoration _innerBoxDecoration(Color color) => BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      );

  BoxDecoration _outerBoxDecoration(Color color) => BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(widget.backgroundBorderRadius),
        ),
        color: color,
      );
}

class BaseSwitcher extends StatefulWidget {
  final Function(bool enabled) callBack;
  final bool initValue;
  final EdgeInsets? padding;

  const BaseSwitcher({
    Key? key,
    required this.callBack,
    this.initValue = false,
    this.padding,
  }) : super(key: key);

  @override
  _BaseSwitcherState createState() => _BaseSwitcherState();
}

class _BaseSwitcherState extends State<BaseSwitcher> {
  late bool checked;

  @override
  void initState() {
    checked = widget.initValue;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant BaseSwitcher oldWidget) {
    checked = widget.initValue;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    const height = 25.0;
    const indicatorWidth = 25.0;

    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: height,
        child: GestureDetector(
          onTap: () {
            setState(() {
              checked = !checked;
            });
            widget.callBack.call(checked);
          },
          behavior: HitTestBehavior.translucent,
          child: Center(
            child: CustomSwitchButton(
              checked: checked,
              indicatorWidth: indicatorWidth,
              unBackgroundColor: context.theme.switcherUnBackgroundColor,
              backgroundColor: context.theme.switcherBackgroundColor,
              animationDuration: const Duration(milliseconds: 350),
              unCheckedColor: context.theme.switcherCheckedColor,
              checkedColor: context.theme.primaryColor,
              buttonWidth: 48,
              buttonHeight: height,
            ),
          ),
        ),
      ),
    );
  }
}
