import 'package:ant_time_flutter/resources/resources.dart';
import 'package:flutter/material.dart';

class BaseIcon extends StatefulWidget {
  final Function() onTap;
  final IconData icon;
  final EdgeInsets? padding;
  final double? width;
  final double? height;
  final Color? hoverColor;
  final Color? iconColor;
  final double? size;
  final Widget? Function(Color)? child;

  const BaseIcon({
    Key? key,
    required this.onTap,
    required this.icon,
    this.padding,
    this.width,
    this.height,
    this.hoverColor,
    this.iconColor,
    this.size,
    this.child,
  }) : super(key: key);

  @override
  State<BaseIcon> createState() => _BaseIconState();
}

class _BaseIconState extends State<BaseIcon> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    Color childColor = _hovered
        ? (widget.hoverColor ?? AppColors.primaryColor)
        : (widget.iconColor ?? Colors.white);

    return Material(
      color: Colors.transparent,
      child: Ink(
        width: widget.width,
        height: widget.height,
        padding: widget.padding,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        child: InkWell(
          hoverColor: Colors.transparent,
          splashColor: AppColors.disabledColor,
          customBorder: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          onTap: widget.onTap,
          onHover: (hovered) => setState(() => _hovered = hovered),
          child: Padding(
            padding: widget.padding ?? const EdgeInsets.all(8),
            child: widget.child?.call(childColor) ??
                Icon(
                  widget.icon,
                  size: widget.size,
                  color: childColor,
                ),
          ),
        ),
      ),
    );
  }
}
