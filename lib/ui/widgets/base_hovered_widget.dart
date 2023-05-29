import 'package:ant_time_flutter/resources/resources.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BaseHoveredWidget extends StatefulWidget {
  final String svgIcon;
  final double width;
  final double height;
  final VoidCallback onTap;
  final String? tooltip;
  final Color? color;

  const BaseHoveredWidget({
    Key? key,
    required this.svgIcon,
    required this.width,
    required this.height,
    required this.onTap,
    this.tooltip,
    this.color,
  }) : super(key: key);

  @override
  _BaseHoveredWidgetState createState() => _BaseHoveredWidgetState();
}

class _BaseHoveredWidgetState extends State<BaseHoveredWidget> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
        ),
        height: widget.width + 8,
        width: widget.width + 8,
        child: InkWell(
          hoverColor: Colors.transparent,
          splashColor: AppColors.disabledColor,
          customBorder: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          ),
          onTap: widget.onTap,
          onHover: (hovered) => setState(() => _hovered = hovered),
          child: SvgPicture.asset(
            widget.svgIcon,
            width: widget.width,
            height: widget.height,
            // fit: BoxFit.scaleDown,
            color: _hovered ? AppColors.primaryColor : (widget.color ?? Colors.white),
          ),
        ),
      ),
    );
  }
}
