import 'package:flutter/material.dart';

import 'package:ant_time_flutter/resources/resources.dart';

class BaseTab extends StatefulWidget {
  final void Function() onTap;
  final String text;
  final bool selected;

  const BaseTab({
    Key? key,
    required this.onTap,
    required this.text,
    required this.selected,
  }) : super(key: key);

  @override
  State<BaseTab> createState() => _BaseTabState();
}

class _BaseTabState extends State<BaseTab> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Ink(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: widget.selected ? context.theme.backgroundColor : Colors.transparent,
        ),
        height: 40,
        child: InkWell(
          hoverColor: Colors.transparent,
          splashColor: context.theme.splashColor,
          customBorder: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          onTap: widget.onTap,
          onHover: (hovered) => setState(() => _hovered = hovered),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Text(
                widget.text,
                style: AppTextStyles.issueSubjectStyle.copyWith(
                  color: widget.selected
                      ? context.theme.primaryColor
                      : (_hovered ? context.theme.primaryColor : AppColors.greyTextColor),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
