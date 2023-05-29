import 'package:ant_time_flutter/resources/resources.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class BaseDropdown<T> extends StatelessWidget {
  final bool disabled;
  final Function(T?)? onChanged;
  final String hint;
  final String Function(T) text;
  final List<T> items;
  final T? value;
  final Color? textColor;
  final double? maxHeight;
  final EdgeInsets? margin;
  final Widget? child;
  final FocusNode? node;

  const BaseDropdown({
    Key? key,
    required this.disabled,
    required this.onChanged,
    required this.hint,
    required this.value,
    required this.items,
    required this.text,
    this.textColor,
    this.maxHeight,
    this.margin,
    this.child,
    this.node,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
        border: Border.all(color: context.theme.borderColor),
        color: disabled ? context.theme.disabledColor : context.theme.backgroundColor,
      ),
      margin: margin,
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<T>(
          hint: Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              hint,
              style: AppTextStyles.greySubStyle,
              textAlign: TextAlign.left,
            ),
          ),
          focusNode: node,
          items: items
              .map(
                (item) => DropdownMenuItem<T>(
                  value: item,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Text(
                      text(item),
                      textAlign: TextAlign.left,
                      style: AppTextStyles.dropdownStyle.copyWith(
                        color: textColor,
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
          value: value,
          onChanged: onChanged,
          buttonWidth: 20,
          buttonHeight: 20,
          itemHeight: 40,
          dropdownPadding: EdgeInsets.zero,
          dropdownMaxHeight: maxHeight,
          buttonOverlayColor: MaterialStateProperty.all(Colors.transparent),
          offset: const Offset(0, -10),
          buttonPadding: const EdgeInsets.only(right: 16),
          itemPadding: const EdgeInsets.only(left: 16),
          alignment: Alignment.centerLeft,
          dropdownDecoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            color: context.theme.backgroundColor,
          ),
          iconDisabledColor: AppColors.disabledColor,
          iconEnabledColor: Colors.black,
          scrollbarAlwaysShow: true,
          iconOnClick: Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Icon(
              AppIcons.arrowUpIcon,
              size: 8,
              color: context.theme.reversedColor,
            ),
          ),
          icon: Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Icon(
              AppIcons.arrowDownIcon,
              size: 8,
              color: context.theme.reversedColor,
            ),
          ),
        ),
      ),
    );
  }
}
