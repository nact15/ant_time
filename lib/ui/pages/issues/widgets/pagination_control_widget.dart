import 'package:ant_time_flutter/resources/resources.dart';
import 'package:flutter/material.dart';

class PaginationControlWidget extends StatefulWidget {
  final Function() onTap;
  final bool enabled;
  final IconData icon;

  const PaginationControlWidget({
    Key? key,
    required this.onTap,
    required this.enabled,
    required this.icon,
  }) : super(key: key);

  @override
  _PaginationControlWidgetState createState() => _PaginationControlWidgetState();
}

class _PaginationControlWidgetState extends State<PaginationControlWidget> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: const BorderRadius.all(Radius.circular(6)),
      onTap: widget.enabled ? widget.onTap : null,
      onHover: (hovered) => setState(() => _hovered = hovered),
      child: Container(
        width: 24,
        height: 20,
        decoration: BoxDecoration(
          color: widget.enabled ? (_hovered ? context.theme.cardColor : context.theme.subColor) : context.theme.backgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(6)),
          border: Border.all(
            color: _hovered ? AppColors.primaryColor : context.theme.borderColor,
          ),
        ),
        padding: const EdgeInsets.only(bottom: 1),
        child: Center(
          child: Icon(
            widget.icon,
            size: 9,
            color: widget.enabled ? context.theme.reversedColor : context.theme.arrowDisabledColor,
          ),
        ),
      ),
    );
  }
}
