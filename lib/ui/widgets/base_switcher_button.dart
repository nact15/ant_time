import 'package:ant_time_flutter/resources/resources.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum BaseSwitcherButtonType { left, right }

class BaseSwitcherButton extends StatefulWidget {
  final String fistButtonText;
  final String secondButtonText;
  final Widget firstWidget;
  final Widget secondWidget;
  final Color? backgroundColor;
  final EdgeInsets? padding;
  final VoidCallback? onLeftButtonPressed;
  final VoidCallback? onRightButtonPressed;

  const BaseSwitcherButton({
    Key? key,
    required this.fistButtonText,
    required this.secondButtonText,
    required this.firstWidget,
    required this.secondWidget,
    this.backgroundColor,
    this.padding,
    this.onLeftButtonPressed,
    this.onRightButtonPressed,
  }) : super(key: key);

  @override
  _BaseSwitcherButtonState createState() => _BaseSwitcherButtonState();
}

class _BaseSwitcherButtonState extends State<BaseSwitcherButton> {
  BaseSwitcherButtonType baseSwitcherButtonType = BaseSwitcherButtonType.left;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 45,
          padding: widget.padding,
          child: Container(
            decoration: const BoxDecoration(
              // color: widget.backgroundColor ?? context.theme.primaryColor,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            padding: const EdgeInsets.all(1),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: LayoutBuilder(
                    builder: (context, constraint) {
                      return AnimatedAlign(
                        alignment: baseSwitcherButtonType == BaseSwitcherButtonType.left
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                        child: Container(
                          width: constraint.maxWidth / 2,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: AppColors.primaryColor,
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Row(
                  children: [
                    _buildButton(
                      BaseSwitcherButtonType.left,
                      widget.fistButtonText,
                    ),
                    _buildButton(
                      BaseSwitcherButtonType.right,
                      widget.secondButtonText,
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                ),
              ],
            ),
          ),
        ),
        if (baseSwitcherButtonType == BaseSwitcherButtonType.left) widget.firstWidget,
        if (baseSwitcherButtonType == BaseSwitcherButtonType.right) widget.secondWidget,
      ],
    );
  }

  void _changeType(BaseSwitcherButtonType type) {
    if (type == baseSwitcherButtonType) {
      return;
    }
    setState(() {
      baseSwitcherButtonType = type;
    });
  }

  Widget _buildButton(BaseSwitcherButtonType type, String title) {
    return Expanded(
      flex: 1,
      child: GestureDetector(
        onTap: () {
          switch (type) {
            case BaseSwitcherButtonType.left:
              widget.onLeftButtonPressed?.call();
              break;
            case BaseSwitcherButtonType.right:
              widget.onRightButtonPressed?.call();
              break;
          }
          _changeType(type);
        },
        child: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Center(
            child: Text(
              title,
              // style: context.theme.getSwitcherTextColor(
              //   type == baseSwitcherButtonType,
              // ),
            ),
          ),
        ),
      ),
    );
  }
}
